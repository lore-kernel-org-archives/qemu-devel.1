Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dv2T0-0004Hl-8F
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dv2Sx-0000LM-2w
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1dv2Sw-0000Ko-TC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2395B806D4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 14:28:33 +0000 (UTC)
References: <1505913885.24609.8.camel@redhat.com>
	<2b739056-081b-593a-6344-50b60d04872b@redhat.com>
	<1505917879.24609.11.camel@redhat.com>
	<394d5515-c9a0-578d-1daf-8af1328f0b4b@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3f8964dc-3fd4-1f0d-c6c6-46afe78a085d@redhat.com>
Date: Thu, 21 Sep 2017 16:28:21 +0200
MIME-Version: 1.0
In-Reply-To: <394d5515-c9a0-578d-1daf-8af1328f0b4b@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm_set_phys_mem: assertion failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

Hi David,
On 20/09/2017 16:34, David Hildenbrand wrote:
> On 20.09.2017 16:31, Gerd Hoffmann wrote:
>>   Hi,
>>
>>> Dropping from os section:
>>>
>>> <loader readonly="yes"
>>> type="pflash">/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-
>>> efi.fd</loader>
>>> <nvram
>>> template="/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-
>>> efi.fd">/var/lib/libvirt/qemu/nvram/fedora-org-drm-qxl-
>>> base_VARS.fd</nvram>
>>
>> Bad idea I guess.
>>
>>> 1) Does the assert trigger right at startup? Or how is it triggered?
>>
>> Yes, right at startup, before OVMF is done initializing.
>> So probably something in OVMF triggers it.
> 
> I'll try to include ovmf to reproduce it.
> 
>>
>>> 2) Does your setup work when dopping the assertion?
>>
>> Can try tomorrow.
I encounter the problem on ARM too. My setup works when dropping the
assertion.

Thanks

Eric
> 
> I think that assertion might not be stable, because properties (romd
> mode) might not be stable and can change. So if it works without the
> assert, dropping it is the right thing to do.
> 
>>
>> cheers,
>>   Gerd
>>
> 
> 
