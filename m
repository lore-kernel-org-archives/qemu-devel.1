Received: from eggs.gnu.org ([2001:4830:134:3::10]:34772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVtIi-0007Sf-Hr
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVtIf-0002Wg-Cm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVtIf-0002WH-3o
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:38:01 -0400
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170713034755-mutt-send-email-mst@kernel.org>
	<20170713152010.GS6020@localhost.localdomain>
	<20170714015435-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dc61d1d8-6a63-4a8f-e0b4-4be450eca8d7@redhat.com>
Date: Fri, 14 Jul 2017 07:37:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170714015435-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 14.07.2017 01:04, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2017 at 12:20:10PM -0300, Eduardo Habkost wrote:
>> On Thu, Jul 13, 2017 at 04:00:00AM +0300, Michael S. Tsirkin wrote:
>>> On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
>>>> We don't want to carry along old machine types forever. If we are able to
>>>> remove the pc machines up to 0.13 one day for example, this would allow
>>>> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
>>>> BARs directly to low memory). Everything up to pc-1.2 is also known to
>>>> have issues with migration.  So let's start with a deprecation message
>>>> for the old machine types so that the (hopefully) few users of these old
>>>> systems start switching over to newer machine types instead.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  Note: Even if we mark all these old machines as deprecated, this ofcourse
>>>>  doesn't mean that we also have to remove them all at once later when we
>>>>  decide to finally really remove some. We could then also start by removing
>>>>  0.10 and 0.11 only, for example (since there should really be no users left
>>>>  for these), or only up to 0.13 (to be able to kill rombar=0).
>>>
>>> So I generally think the main issue is that machine types are conflating
>>> two things. One is saying "I want to be able to migrate from/to QEMU X".
>>> Another is saying "I want to look to guests as if I am QEMU X
>>> but I restart gurst on the new QEMU".
>>>
>>> First is generally a superset of the second, but only a subset of
>>> users needs the first. And while there's a very good chance we
>>> are actually pretty close to supporting the second even for very
>>> old machine types, I doubt we are actually able to migrate to/from
>>> these old QEMU versions since it is so hard to test.
>>>
>>> So IMHO, a more significant step with a long term impact would be to
>>> support splitting these things up.
>>
>> I agree they are different things, but do we really have
>> volunteers willing to maintain a machine-type just because of the
>> latter?  Setting the same deprecation policy for the two features
>> sounds simpler to me.
> 
> Removing the former might kind of work just this once on the assumption
> that we did not have real users back then, but fundamentally users have
> no safe way to upgrade machine types right now. It's stored in the
> machine XML at install time and that's it, and reinstalling guests
> is very painful.
> 
> So starting with version X when we did have real users, we really have
> to maintain the latter literally forever, volunteers or not.

Do we? If someone has a VM that depends on a veeery old machine type
(and it can not be started with a newer machine type - which is quite
unlikely since they are normally very similar), I guess they could also
simply use older versions of QEMU for that VM instead.

 Thomas
