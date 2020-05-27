Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598DBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 19:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDD820835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 19:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+kt0LV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDD820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je26U-0008TP-95
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 15:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1je25s-0007k4-AE
 for qemu-devel@nongnu.org; Wed, 27 May 2020 15:52:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1je25r-0006d9-Fg
 for qemu-devel@nongnu.org; Wed, 27 May 2020 15:52:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id u13so752677wml.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tQfh5E3DggoTgfjWD8kR8V2egDetz3Y8KURmb7J6yfA=;
 b=q+kt0LV/ylkJru81cfqTQIIr0wf6oxqb+1Wu6n3ZLe0aeAohtgsHgmB2xjVrIuPBJS
 V53Q7Wq4crvAKkgdJA3kyuNOUNGNU6UC+p9c/8GUWtQLcxY4Pgi/+wVz+BHHmZ4RLoPP
 evV8FRur7OsS5nxCf7pBIV7Y4VczSP4jRsimas9NNimzPQ55c06j7R4+lKGNtmUjs5wT
 BetUHE2OZRrCl0MksAigVDTwxrnmHWJixoTE/pTIcZbzXJ7IESf1s85C+xvkrp3zaFCh
 vVG5LliGwvGruD34q3yjFQFTob5v0qHPG8k4KHUf8y1QKS/sfdJnh6zy8v6H6v4gWHov
 8ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tQfh5E3DggoTgfjWD8kR8V2egDetz3Y8KURmb7J6yfA=;
 b=nYw5L77olnWa8MgUANy9G2lJlieit9F7i6SOVqKh8vVxzRZI6SgZC9T8/d/vW4tX5P
 q+c62fC1614pgD7F5GVHpAieKAzU84DVFkilXBgGiVM4MotO9oSsyv9SMSYiRNwPOVZj
 oZ3hDFtXnNH9DW5JMEtthhPTLfVpuuMlbhMVCL7R772uhvWSyD/pxjWtUvhaJdH7d6k6
 7our/LLOt3NrOorOxuQHBweg84UwtoWS7YbI+zbQo5NuRSeg4DaBsQgdEgJwUsO2OxW7
 IMZH7+7qKd7Ld1ggeaKsh7LGKb1etuzXe+5sHIgVyK+3CMBHiFA9H4z0HRKB7AbqubOY
 HyXg==
X-Gm-Message-State: AOAM5334PhRr0/Klf3gZu1Hb+bvtIM9FA/S/NkGI7kpihNPIUyEWKU61
 5NHw2PhyQitL6PqoCjMJfg1BPQAjFZh5ZypkFmI=
X-Google-Smtp-Source: ABdhPJwHsaiarh7a5PVl6uZ68JsU9Hqx2tLVuHgmRf1Ry0pHRnQTf7lOJlZ9SijDE8pY4MVAVv/48veWlQmo/Vtr9Zg=
X-Received: by 2002:a1c:6182:: with SMTP id v124mr5688849wmb.30.1590609121535; 
 Wed, 27 May 2020 12:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200525084511.51379-1-david@redhat.com>
 <20200526132840.GD108774@redhat.com>
 <dddadb61-b0af-a9c0-64f8-ac3c47d37566@redhat.com>
 <20200526142219.GE108774@redhat.com>
 <32210631-5933-088c-52e5-9e9eb2d800e3@redhat.com>
In-Reply-To: <32210631-5933-088c-52e5-9e9eb2d800e3@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 27 May 2020 21:51:50 +0200
Message-ID: <CAM9Jb+hxR2Q22YpBcA0-Rv=gbbawVhZLR-Ld7_YT7hn7S9-UsA@mail.gmail.com>
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on
 all buses
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David, Vivek,
s
> >> Hi Vivek,
> >>
> >> you have to declare the maxMemory option. Memory devices like
> >> virtio-pmem-pci reside in RAM like a pc-dimm or a nvdimm. If your
> >> virtio-pmem device will be 4GB, you have to add that to maxMemory.
> >>
> >>   <memory unit='GiB'>64</memory>
> >>   <maxMemory unit='GiB'>68</maxMemory>
> >>   <currentMemory unit='GiB'>64</currentMemory>
> >>
> >> (you might have to add "slots='0'" or "slots='1'" to maxMemory to make
> >> libvirt happy)
> >
> > Ok, tried that.
> >
> > <maxMemory slots='1' unit='KiB'>134217728</maxMemory>
> >
> > And now it complains about.
> >
> > error: unsupported configuration: At least one numa node has to be configured when enabling memory hotplug
> >
> > So ultimately it seems to be wanting me to somehow enable memory hotplug
> > to be able to use virtio-pmem?
>
> That's a libvirt error message. Maybe I am confused how libvirt maps
> these parameters to QEMU ...
>
> NVDIMMs under libvirt seem to be easy:
>
> https://www.redhat.com/archives/libvir-list/2016-August/msg00055.html
>
> Maybe the issue is that virtio-pmem has not been properly integrated
> into libvirt yet:
>
> https://www.redhat.com/archives/libvir-list/2019-August/msg00007.html
>
> And you attempts to force virtio-pmem in via qemu args does not work
> properly.
>
> Maybe maxMemory in libvirt does not directly map to the QEMU variant to
> define the maximum physical address space reserved also for any memory
> devices (DIMMs, NVDIMMs, virtio-pmem, ...). Any libvirt experts that can
> help?
>
> @Pankaj, did you ever get it to run with libvirt?

I did not run virtio-pmem with libvirt. That requires work at libvirt side.
Created [1] document to run from Qemu command line.

[1] https://github.com/qemu/qemu/blob/master/docs/virtio-pmem.rst

