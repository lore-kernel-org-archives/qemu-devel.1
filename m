Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B22DC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B614206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B614206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyjSA-0004vj-Dr
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 17:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ymankad@redhat.com>) id 1hyjRO-0004U9-AA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ymankad@redhat.com>) id 1hyjRM-0005H1-H3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:07:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ymankad@redhat.com>) id 1hyjRM-0005Fo-8o
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 569D8309DEF3;
 Fri, 16 Aug 2019 21:07:14 +0000 (UTC)
Received: from apollo.usersys.redhat.com (unused-10-15-17-159.yyz.redhat.com
 [10.15.17.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C83175D9DC;
 Fri, 16 Aug 2019 21:07:10 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-4-ehabkost@redhat.com>
 <87pnl5sks3.fsf@dusky.pond.sub.org>
 <20190816074932.GK13569@beluga.usersys.redhat.com>
 <87h86hpae5.fsf@dusky.pond.sub.org> <20190816174241.GE3908@habkost.net>
From: Yash Mankad <ymankad@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ymankad@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFecwEYBCAC7QUnuTKRrz39gLumVG+KNB8XmHqHKypYPMkdJNLx33LAhmDVEeBEB6Zyn
 ryVtNClL4GVrmDOROp53kIkJh4uSAeu71w3/RJLrrHIs/NlFZ1cH3hEAwShLKYkXoVfqBN3m
 zhbqyndmPy8fviOIDcyzEBEIDbgsLgMebJTAto/ihLgEeG9dMF4qUuCcb3sWIao/WHSr9XHB
 OtZnvVUGueIM3DqEC2g5BN8025riOOL3UGRmIctJR+2dM+j0aCIbARGv1B66o300gJfjxm24
 /CbD/I6Wt2PHrNv/d4nXjfNElaBCiVw9513m2maFJeFaSPJpAGZjyDN/niNcpvxg6XaLABEB
 AAG0P1lhc2ggTWFua2FkIChTb2Z0d2FyZSBFbmdpbmVlciBhdCBSZWQgSGF0KSA8eW1hbmth
 ZEByZWRoYXQuY29tPokBNwQTAQgAIQUCV5zARgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIX
 gAAKCRBjP1s2LzTrMJhfB/9mRNS3eMAy17wRSjnR1/AtNZ2qwBbyjnor0+Q7UfYUXKvFBNJo
 LnX6zphFJ/fZMqIM5BrE7T90Mm5Qy3qoK1c0QibN97OECrPn9epGPKiiI+1WZrIX9S3crCui
 hyIS4IuOOmgtVJx+akWCbfYPaybNsTPLBFJZ0+aATSe9Nbeb4XUS3RAqlRUEdejNGxxtKLtZ
 xgXsmL/il6Fp4EX53H1+d83Rk4V+S2KvMfrFEB+mxF7JFUv0E071br42po/EDnYj2wLM/STh
 Fgp5LO4qTPrwD8mllibLSF6ZCrjNYW1EctJF7oYbfFXwPUh9LWh0opKwzo8ne5ZN/4hzexHU
 4MnquQENBFecwEYBCACnrkQgxRis8b1DRRIWu+Gxxp4Xv85c19A3IyNudvihSNSSV8mSZ+ei
 9Xev80IhgExf+1MeTPvuWmD1FogqC5Pi6bEs29ZZvSde+DH1BeVoKVn4zY+rCSqyrlRfx8Zd
 xJXIICfOgfDRjDf0nKPiI14ujdT0zMOPJHQ8wf267kMWmS32eQPTLJmemhl9WhEett+i1WLq
 84DjbEhtkTO6FdboEcTN1fMSpkXz+jgfvgCCZIfJJ+AI/V/VjBBn264VdDdOE/AFfc6B1QYf
 6X3npdUmXjlE5QIadoaOHf6e+qMSEchKfMa9ban0dH1THVAm2Z8Ji+l0tNYJ/e3mndXcVJv7
 ABEBAAGJAR8EGAEIAAkFAlecwEYCGwwACgkQYz9bNi806zAlVwgAj0auI5iVWxdCEnxGDAFC
 7uuZeBfiRGUwnaeRLcs2N6zLdN7Y9aoLv0RMrQhTP1DiIOi2xuCiUeGAY533fIpQOtE+AHgY
 fFqUG9gwK9Web5Tec+SNOBXeULRd8flo3RIkKMUR6RBynHkvEt2WbGRfr4gP6RuYzwBL1EWv
 nigkhVXsLA+hyut5C8OMXcxG61vbat2duyBgqROV0UbMau9Nr+t5w2isusgHe3fia1h5uwsh
 3UDO4xAD/Il16hZqcPbgKW3+S7uR3V2LKwCqX0S/9gYwaIfiBgvEt7EAbj2YZfYvcWjbBwDu
 stjeTrSRCejEli4lN7PsSM6/NaLsIPKMgQ==
Message-ID: <75655410-9af9-e463-9471-675299929bde@redhat.com>
Date: Fri, 16 Aug 2019 17:07:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816174241.GE3908@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 21:07:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pc: Don't make CPU properties
 mandatory unless necessary
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Erik Skultety <eskultet@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 "Danilo C. L. de Paula" <ddepaula@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/16/19 1:42 PM, Eduardo Habkost wrote:
> On Fri, Aug 16, 2019 at 02:22:58PM +0200, Markus Armbruster wrote:
>> Erik Skultety <eskultet@redhat.com> writes:
>>
>>> On Fri, Aug 16, 2019 at 08:10:20AM +0200, Markus Armbruster wrote:
>>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>>
>>>>> We have this issue reported when using libvirt to hotplug CPUs:
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1741451
>>>>>
>>>>> Basically, libvirt is not copying die-id from
>>>>> query-hotpluggable-cpus, but die-id is now mandatory.
>>>> Uh-oh, "is now mandatory": making an optional property mandatory is =
an
>>>> incompatible change.  When did we do that?  Commit hash, please.
>>>>
>>>> [...]
>>>>
>>> I don't even see it as being optional ever - the property wasn't even=

>>> recognized before commit 176d2cda0de introduced it as mandatory.
>> Compatibility break.
>>
>> Commit 176d2cda0de is in v4.1.0.  If I had learned about it a bit
>> earlier, I would've argued for a last minute fix or a revert.  Now we
>> have a regression in the release.
>>
>> Eduardo, I think this fix should go into v4.1.1.  Please add cc:
>> qemu-stable.
> I did it in v2.
>
>> How can we best avoid such compatibility breaks to slip in undetected?=

>>
>> A static checker would be nice.  For vmstate, we have
>> scripts/vmstate-static-checker.py.  Not sure it's used.
> I don't think this specific bug would be detected with a static
> checker.  "die-id is mandatory" is not something that can be
> extracted by looking at QOM data structures.  The new rule was
> being enforced by the hotplug handler callbacks, and the hotplug
> handler call tree is a bit complex (too complex for my taste, but
> I digress).
>
> We could have detected this with a simple CPU hotplug automated
> test case, though.  Or with a very simple -device test case like
> the one I have submitted with this patch.
>
> This was detected by libvirt automated test cases.  It would be
> nice if this was run during the -rc stage and not only after the
> 4.1.0 release, though.
>
> I don't know details of the test job.  Danilo, Mirek, Yash: do
> you know how this bug was detected, and what we could do to run
> the same test jobs in upstream QEMU release candidates?

This bug was caught by our internal gating tests.

The libvirt gating tests for the virt module include the
following Avocado-VT test case:

libvirt_vcpu_plug_unplug.positive_test.vcpu_set.live.vm_operate.save

This job failed with the error that you can see in the description
of the BZ#1741451 [0].

If you think that this would have been caught by a simple hotplug
case, I'd recommend adding a test for hotplug to avocado_qemu.
Otherwise, if you want, I can look into adding this particular
libvirt test case to our QEMU CI efforts.

Thanks,
Yash

[0] https://bugzilla.redhat.com/show_bug.cgi?id=3D1741451#c0



>



