Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97471C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF1E2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/Zg0CR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF1E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtWJ-00040A-Nn
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVtTB-00020k-0k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVtT6-0003hq-70
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603445676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQrtpXrf97XKuuWbADBamUB+LrsojgtsZVQVU2YWvjA=;
 b=d/Zg0CR8VWbyApyg1jV7tOVVIVKOk0Ep/I4ci9Fpc//gNxRot4+aaT4CiZJ8UfaUkrqPFQ
 +1kZaTgfF56if3VVkWjAS4vYt1J2Llh1ymtmniwW+77D/9suG2w1bGJtTKzb8NRh939QXD
 R97PqMdBcSvmrAg8/wtUxEJpVtOp8pw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-oQAAolEYOtGAehGLVeogZw-1; Fri, 23 Oct 2020 05:34:33 -0400
X-MC-Unique: oQAAolEYOtGAehGLVeogZw-1
Received: by mail-wr1-f70.google.com with SMTP id v5so391484wrr.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 02:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cQrtpXrf97XKuuWbADBamUB+LrsojgtsZVQVU2YWvjA=;
 b=Vl1C8MELYyEnMPVbwhZOjYCFW5z9OVTqB2AnH2u27+4kwsY3nwzmxZLV5OwovXIYTl
 ky3C7XtCxkXdhP8mMRq9tJxT1UlwJUC+TdGLckXV9YDMCyvDfUFMFE2Kx/mHmCPWP9Yt
 eUFrpyA8qbpDgBqtXHNHVB0j8L4gNi9tr1OD6EBbr8GDwSJvik6DRMNWxNfRIwtlG1Aw
 HKxUBWlqYAhpRRqxCCDqSvhfVM+Z0dN02dkNskUfSi+zr409/HzCSW+Bt7sR6txdQBSm
 6m92kRLO+UeKwGJ67kkRLTGINrqQ6SS8yUytKuR6NeDVvraKFe6t7ldBX6QZAiMftRU9
 mXiQ==
X-Gm-Message-State: AOAM530y2v6bPCt4K0ugE4QDbaXQHRuQN0Nr/Jy4WzMs71sNj0SIlZIK
 LFO1jJlsnZ/LLxWpP5wiAS5SSr4rwIX9zKu3Ni+xL9ZgL4EoFxsZh76X69bdzCL4htuggmpBEVS
 nMano9P/ifFTlrM0=
X-Received: by 2002:a5d:480b:: with SMTP id l11mr1655532wrq.225.1603445671722; 
 Fri, 23 Oct 2020 02:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaRI7bEYKsiczdlw0KCwJoH1Qd5UD/TwRL358PeCCF7vdNYJQ6pnNiquMdGYf26+bikrFCSA==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr1655511wrq.225.1603445671407; 
 Fri, 23 Oct 2020 02:34:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x6sm2328796wmb.17.2020.10.23.02.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 02:34:30 -0700 (PDT)
Subject: Should we keep using Avocado for functional testing? (was: Re: [PULL
 22/23] hw/sd: Fix incorrect populated function switch status data
 structure)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
 <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
 <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
 <db561779-005b-c358-3e72-e1169ef49faf@amsat.org>
Message-ID: <26e41113-e124-63f7-64c5-2d42011c5cfb@redhat.com>
Date: Fri, 23 Oct 2020 11:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <db561779-005b-c358-3e72-e1169ef49faf@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 11:23 AM, Philippe Mathieu-Daudé wrote:
> On 10/23/20 4:02 AM, Bin Meng wrote:
>> Hi Niek,
>>
>> On Thu, Oct 22, 2020 at 11:20 PM Niek Linnenbank
>> <nieklinnenbank@gmail.com> wrote:
>>>
>>> Hi Bin, Philippe,
>>>
>>> If im correct the acceptance tests for orange pi need to be run with 
>>> a flag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be 
>>> run using the armbian mirror. So if you pass that flag on the same 
>>> command that Philippe gave, the rests should run.
>>
>> Thank you for the hints. Actually I noticed the environment variable
>> ARMBIAN_ARTIFACTS_CACHED when looking at the test codes, but after I
>> turned on the flag it still could not download the test asset from the
>> apt.armbian.com website.
> 
> This patch could help you, but it use a different image [*]:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg737760.html
> (I haven't tested the image yet but I assume the same bug is present).
> 
>>
>>> I have a follow up question and Im interested to hear your opinion on 
>>> that Philippe. Should we perhaps update the orange pi tests (and 
>>> maybe others) so they use a reliable mirror that we can control, for 
>>> example a github repo? I would be happy to create a repo for that, at 
>>> least for the orange pi tests. But maybe there is already something 
>>> planned as a more general solution for artifacts of other machines as 
>>> well?
> 
> This is a technical debt between the Avocado and QEMU communities
> (or a misunderstanding?).
> 
> QEMU community understood the Avocado caching would be an helpful
> feature, but it ended being more of a problem.
> 
> 
> I.e. here Niek, Michael Roth and myself still have the image cached,
> so we can keep running the tests committed to the repository. You
> Bin can not, as the armbian mirror is not stable and remove the old
> image.
> 
> The old image (Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img)
> has been manually tested by Niek and myself, I enabled tracing and
> look at the SD packets for some time, was happy how the model worked
> and decided we should keep running a test with this particular image.
> 
> Armbian released new images, in particular the one Cleber sent in [*]:
> Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz. While it might
> work similarly, I haven't tested it, and don't have time to do again
> the same audit.
>  From my experience with the Raspberry Pi, these images never work the
> same way, as the Linux kernel evolves quickly with these kinda recent
> embedded boards. The QEMU raspi models have to emulate new devices
> (or complete current ones) every years, because Linux started to use
> a device differently, or started to use a part of the SoC that was not
> used before. Either the kernel doesn't boot, or there are side-effect
> later when userspace program is executed. PITA to debug TBH. For this
> reason I disagree with updating test images to the latest releases.
> 
> It would be nice to know QEMU works with the latest Armbian, but
> nobody popped up on the mailing list asking for it. I am personally
> happy enough using the 19.11 release for now.

Back to the cache problem, I started to ask 2 years ago,
https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.html
note this is the exact situation we are having:

 >> - What will happens if I add tests downloading running on their
 >> compiled u-boot
 >> 
(https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-1750/u-boot.bin)
 >> and the company decides to remove this old directory?
 >> Since sometimes old open-source software are hard to rebuild with
 >> recent compilers, should we consider to use a public storage to keep
 >> open-source (signed) blobs we can use for integration testing?
 >
 > For Avocado-VT, there are the JeOS images[1], which we keep on a test
 > "assets" directory.  We have a lot of storage/bandwidth availability,
 > so it can be used for other assets proven to be necessary for tests.
 >
 > As long as distribution rights and licensing are not issues, we can
 > definitely use the same server for kernels, u-boot images and what
 > not.
 >
 > [1] - https://avocado-project.org/data/assets/


We discussed about this again last year at the KVM forum. Various
RFE have been filled:
https://www.mail-archive.com/avocado-devel@redhat.com/msg01183.html


What we need is a QEMU community file server similar to the asset
one used by the Avocado community. The problem is who is going to
pay and sysadmin it. IIRC Gerd suggested to use GitLab Page, but
the artifact file size is limited to a maximum of 1GiB:
https://docs.gitlab.com/ee/user/gitlab_com/#gitlab-pages
Alternative is to use a git-lfs server:
https://docs.gitlab.com/ee/topics/git/lfs/#hosting-lfs-objects-externally
This is now a project management problem.

Next week is the KVM forum 2020 and there might be a BoF session
to talk about that:
https://kvmforum2020.sched.com/overview/type/Birds+of+a+Feather+Sessions+(BoF)


Now that the QEMU community started to use gitlab-ci more and more
I received complains that Avocado is not practical (hard to
understand how to reproduce command line to debug, options to use
not clear, timeouts not clear, why download all artifacts to run
a single test, various issues regarding caching, cache filled /home
filesystem) so I have been asked to look at Avocado alternatives,
because we want contributors run more tests and CI, not them be
scared by it.
I haven't looked at alternatives yet, from the various features
we could have use, the biggest one is the ability to interact with
the serial console. And that feature is duplicated with the VM
testing class: tests/vm/basevm.py.
The SSH session used in linux_ssh_mips_malta.py is similar to the
one from basevm.py too (see 'make vm-boot-ssh-%').
Some tests are not 'acceptance' but simple qtest written in Python,
such cpu_queries.py / pc_cpu_hotplug_props.py / migration.py /
pc_cpu_hotplug_props.py / x86_cpu_model_versions.py.

The classes I find practical are downloading artifact, uncompressing
or extracting archive, and eventually the cloudinit one. But we can 
probably use them directly.


Lot of material to discuss :)

Regards,

Phil.


