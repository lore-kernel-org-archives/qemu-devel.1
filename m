Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA0C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 15:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EF520725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mli0eoF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EF520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibRLv-0002dn-Sc
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 10:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibRKi-0001w5-MF
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibRKh-0007ON-Ih
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:40:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ibRKh-0007NM-Ac
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:40:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id b18so41001583wrj.8
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sGCDm/a/FHeafNbE+MNSSpl3yRtPXLBvDvQ7hemCMmQ=;
 b=mli0eoF2ic0jorixy+JnE6b0D+N7o29bcMlMucr2tjxw8vgGjKGeEtm2yO/b8HHUq0
 AFdgZCWFQxLxYTsiAL6GlTBxAeb0/SmnZeOPLMwChArSZ9JDfp1gaIERe8oqZ1jwW23J
 Mq0mtcOcyx36XEJlofmnkzPQdZ6Tqi5opSDSZnVp2CfsTB6G36DX+i5065BUeeGKtGcn
 gbkwjG4+yUuonCfjEcCSxOsNnWgKx+sLq5IjWd7ZJpLWG5BxDcfJK8qTN/tmBxIIwOA0
 b0s2OHDfUyZOgonTu1hISVBG+2+CLRrsJXYWX9u5tfAuBYacKfL1sHSSVV6UpiNN8wBX
 8euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sGCDm/a/FHeafNbE+MNSSpl3yRtPXLBvDvQ7hemCMmQ=;
 b=AZAMowUtq0IhtAdMts3qBsN3u6mGgtjT5S3jAovzK9YEzQC5voI44semgfBG9i6YV3
 LH1MGAnXUN85e+Ws52DittwjYaZruM0Mb8krHm3ConuZiR9Y74IWqwE9GPvE5E3VsnqY
 5nV9YVxRyOXMEitdPZ9pwqK7lGpiSmX3Ow3jd3yRj18VKU7LhI4ROXBFWfKDdoNUpHEB
 Hfjl1ligakCV5/KSi//zpU+xIBJItbqf2A1JBHYzBAbf2Gxmx3Rr03LZsKz9iLLWbxqK
 ItPuBnyqcddD11nh3tlxVZWREoP5wShm+bx28NYCUv1VrQ2SHXhwbSgHGn5Xrp/FKsGc
 agsw==
X-Gm-Message-State: APjAAAU2ee0XMARZ0zKf8LvOAJHY102NJqnnth7PcvX1m8DO6j0jmUvo
 Oj3MxR1Qkx6XbeRoh5tVd1X8P0iwqRl0n39vm7henIzyTsU=
X-Google-Smtp-Source: APXvYqzaoC5cPoNXhabGXNpRamf3s9FHwastL6a2d+KjFx5BHHxivuN2kTI1Plhi6e04LNa7jo2s7z+zOpLZtWE2tEo=
X-Received: by 2002:adf:e310:: with SMTP id b16mr57161881wrj.202.1575214822175; 
 Sun, 01 Dec 2019 07:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128161021.GA14595@habkost.net>
 <fb122bbe-3fc4-e3cd-899a-c3538237203a@redhat.com>
 <20191129202137.GI14595@habkost.net>
In-Reply-To: <20191129202137.GI14595@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 1 Dec 2019 19:40:09 +0400
Message-ID: <CAJ+F1CL1s450gUmGK9hzSgk4Y3XSNTzdt2OdU6z65y1hKGjxeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Nov 30, 2019 at 12:23 AM Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> On Fri, Nov 29, 2019 at 10:31:36AM +0100, Paolo Bonzini wrote:
> > On 28/11/19 17:10, Eduardo Habkost wrote:
> > > On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > >> Hi,
> > >>
> > >> Setting up shared memory for vhost-user is a bit complicated from
> > >> command line, as it requires NUMA setup such as: m 4G -object
> > >> memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Do=
n -numa
> > >> node,memdev=3Dmem.
> > >>
> > >> Instead, I suggest to add a -mem-shared option for non-numa setups,
> > >> that will make the -mem-path or anonymouse memory shareable.
> > >
> > > Can we make this be a "-m" option?
> > >
> > > Or, even better: can we make "-m" options be automatically
> > > translated to memory-backend-* options somehow?
> > >
> >
> > The original idea was to always support one NUMA node, so that you coul=
d
> > do "-numa node,memdev=3D..." to specify a memory backend with -object.
> > However, this is not possible anymore since
> >
> >     if (!mc->cpu_index_to_instance_props ||
> >         !mc->get_default_cpu_node_id) {
> >         error_setg(errp, "NUMA is not supported by this machine-type");
> >         return;
> >     }
> >
> > has been added to hw/core/numa.c.
> >
> > Therefore, I think instead of -mem-shared we should add a "-m
> > memdev=3D..." option.  This option:
> >
> > * would be mutually exclusive with both -mem-path
> >
> > * would be handled from allocate_system_memory_nonnuma.
> >
> > * could be mutually exclusive "-numa node", or could just be mutually
> > exclusive with "-numa node,memdev=3D..." (the logical conclusion of tha=
t
> > however would be an undeprecation of "-numa node,mem=3D...", so that ha=
s
> > to be taken into account as well).
>
> I completely agree we could do this.  I just think this misses
> completely the point of this series, because usability of:
>
>   -object memory-backend-file,...,share=3Don,id=3Dmem -m ...,memdev=3Dmem
>
> is not much better than the usability of:
>
>   -object memory-backend-file,...,share=3Don,id=3Dmem -numa node,memdev=
=3Dmem
>

+1
Perhaps when all RAM allocation will occur through memory-backend,
"-mem-shared" could be simply an alias to "-global
memory-backend.shared=3Don"


--=20
Marc-Andr=C3=A9 Lureau

