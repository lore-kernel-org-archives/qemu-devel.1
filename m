Received: from eggs.gnu.org ([2001:4830:134:3::10]:45441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUH1l-0006Je-E4
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUGtY-0006FD-23
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:02:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUGtX-0006EY-QW
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:02:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4JrSdq101077
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 15:02:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5xvab98u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 15:02:10 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Dec 2018 20:02:07 -0000
References: <154394083644.28192.8501647946108201466.stgit@gimli.home>
	<154394987445.795.4102526920089904508.stgit@gimli.home>
	<6bc68937-ec9e-d28f-9468-5ee9ba08ef52@de.ibm.com>
	<20181204122647.3a560066@x1.home>
	<CAFEAcA_5tDfoPZaPcheMGUyq_ibbvT+GE8WKgXnHf8SnxioPvA@mail.gmail.com>
	<20181204125621.0ad30dc0@x1.home>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Dec 2018 21:02:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181204125621.0ad30dc0@x1.home>
Content-Language: en-US
Message-Id: <05a7106f-a783-bd27-19f8-2605b54e9ad3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3.1 8/9] q35/440fx/arm/spapr/ccw:
 Add QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>



On 04.12.2018 20:56, Alex Williamson wrote:
> On Tue, 4 Dec 2018 19:29:25 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Tue, 4 Dec 2018 at 19:26, Alex Williamson <alex.williamson@redhat.com> wrote:
>>>
>>> On Tue, 4 Dec 2018 20:16:44 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>  
>>>> I think Conny has already added the s390/ccw part to her next tree.
>>>> From a quick glimpse both patches look identical.  
>>>
>>> If so then we can just use the original v3 version of this patch that
>>> touches all but ccw and let them come together in mainline.  My
>>> assumption is that Peter is only trying to make sure all versioned
>>> machines are updated early in this release, not necessarily that
>>> they need to be updated together.  
>>
>> Yes, that's the idea. I also think it's a suboptimal idea
>> to include the version-number-bump patch in a series that's
>> adding some feature, because then if the feature itself
>> has to go through several rounds of patch review the
>> version-number-bump patch is stuck unapplied (we saw that
>> at the end of the 3.1 cycle), or it gets bumped by some
>> other unrelated series and then there's a merge conflict.
>> But that's more of a things-for-next time remark, no need
>> to rearrange this now.
> 
> If you and the other stakeholders agree, you are more than welcome to
> pluck this patch from the series and apply it as soon as 4.0 opens.  It
> might make things a tiny bit easier down the road to avoid the
> conflicts since we seem to have multiple contenders vying for this
> update.  Maybe the best practice going forward is to open the merge
> window with such a commit.  Thanks,

I agree. Something like this should be the first commit after each release.
