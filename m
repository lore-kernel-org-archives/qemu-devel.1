Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctGru-0002u9-TP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctGrp-0001Px-Ur
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ctGrp-0001Oi-PR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6FF3437F77
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 16:54:40 +0000 (UTC)
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
	<3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
	<20170329164646.GD2501@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <492932b1-e317-0cd9-5eb5-9e49f6c0b1ba@redhat.com>
Date: Wed, 29 Mar 2017 18:54:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170329164646.GD2501@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Deprecating old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On 29.03.2017 18:46, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> On 27.03.2017 21:04, John Snow wrote:
>>>
>>> On 03/27/2017 04:06 AM, Thomas Huth wrote:
>>>> On 24.03.2017 23:10, John Snow wrote:
>> [...]
>>>>> I have a list of things I want to axe...
>>>>
>>>> I've started a Wiki page with such a list here:
>>>>
>>>> http://wiki.qemu-project.org/Features/LegacyRemoval
>>>>
>>>> Feel free to amend!
>>>
>>> Absolutely!
>>
>> By the way, what about old machine types like "pc-0.10" ? Do we want to
>> carry them along forever (e.g. since it is not too complicated to
>> maintain?), or shall we get rid of those one day (e.g. with QEMU 3.0), too?
> 
> It seems reasonable to slowly deprecate them.
> I'm just not sure how slowly.

We could maybe at least start with "pc-0.10", and maybe also "pc-0.11"
... if nobody complains afterwards, we can get rid of the other pc-0.x
machines later with QEMU 4.0 (or so).

 Thomas
