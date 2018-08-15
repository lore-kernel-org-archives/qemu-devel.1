Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpown-0003QP-V3
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpowi-00088i-IE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:06:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpowi-00085A-51
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:06:16 -0400
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
	<1534258018-22859-6-git-send-email-thuth@redhat.com>
	<1d700466-d271-f1b6-d7e4-ea82608d984f@redhat.com>
	<33446506-a101-69c3-9d31-c1b8ef8d8b32@redhat.com>
	<e5535b93-990d-94c9-562f-8be49be4c2a3@redhat.com>
	<f0d25fe6-f526-abf0-6f8a-98cc66592112@redhat.com>
	<4955cb45-df23-608b-3444-c11409894bff@redhat.com>
	<86709942-5a53-0e0d-0da4-a22a96da3078@redhat.com>
	<f910f202-a1fb-cea3-ee29-7dc243bb6304@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cac5ecfb-5420-daef-87bf-fc8f04a60609@redhat.com>
Date: Wed, 15 Aug 2018 08:06:11 +0200
MIME-Version: 1.0
In-Reply-To: <f910f202-a1fb-cea3-ee29-7dc243bb6304@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 08/14/2018 07:10 PM, Paolo Bonzini wrote:
> On 14/08/2018 18:11, Thomas Huth wrote:
>> On 08/14/2018 06:03 PM, Paolo Bonzini wrote:
>>> On 14/08/2018 18:01, Thomas Huth wrote:
>>>> On 08/14/2018 05:57 PM, Paolo Bonzini wrote:
>>>>> On 14/08/2018 17:43, Thomas Huth wrote:
>>>>>> The machines which emulate an embedded system often always create a NIC
>>>>>> (since it is hard-wired on the board, not optional). But since there is
>>>>>> no back-end on the host side with "-nodefaults", the net_check_clients()
>>>>>> function complains in this case.
>>>>>
>>>>> [...] is the message unnecessary even in normal operation?
>>>>
>>>> I think it is still needed, since you could also screw up your command
>>>> line parameters after specifying -nodefaults (e.g. "-nodefaults -net
>>>> nic" without giving an additional "-net user" or something similar).
>>>
>>> True.  Though it cannot happen with -nic, so another possibility is to
>>> give it only if -net was used?
>>
>> Sorry, I don't quite get you ... this is a generic check in vl.c, how
>> should this code know whether the NICs have been specified with -nic or
>> -net?
> 
> 	case QEMU_OPTION_net:
> 	    had_net = true;
> 	    ...
> 
> 	if (!default_net && had_net) {
> 	    net_check_clients();
> 	}
> 
> :)

Ah, ok, thanks, I somehow only had that nd_table stuff in mind... That
change looks reasonable to me, I'll give it a try!

 Thomas
