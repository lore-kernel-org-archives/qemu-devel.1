Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87547C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2436206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 20:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp77XZiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2436206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kORoT-0007sQ-N1
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 16:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kORmw-0006kD-VK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:36:23 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonatan.p@gmail.com>)
 id 1kORmv-00076K-9X
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 16:36:22 -0400
Received: by mail-il1-x141.google.com with SMTP id j13so2441737ilc.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fsxEuBFc8xqo9BALWEZzORq+cDkRYS3zFi8sT3gxjuE=;
 b=bp77XZizOIOyAi4OwxBGdENEz2SRaYt5g3daLLk1u26rpFTORrI32rFrYXpRlDy50T
 ZIhTzljtASI0swtxBssFZG7p6lCaBjWBRFunK7AytevWxbtnjHRWfj4Ln0gzHIYzgNWO
 pF/hmPHX31o9eajrAexMQzicg7SG2HiOHebqi8VhDlOhGQKKYFC1dimZLWywl69Vb4Hm
 pV5RhBNvR3DoYytp331I40ReH4r9V/Fylkt/fefkOp+jcZt7+Y/4Zb1e2NtFAehluc+G
 eMv483XgkS72HWg94MV+Azc5G5CdDylrnlpTzQd0yJiodSdQ+nhYzkAEKMcuPBUVUFjg
 sARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fsxEuBFc8xqo9BALWEZzORq+cDkRYS3zFi8sT3gxjuE=;
 b=BJuPZT40LRJjIQnpSoxLV7z28tZnFlUf+u97GcaktDQWZ2LFgy9LkCcEx4qwBjgPVj
 35Gqw6LvXjWnU+Or84JZ8ZMcLq7cvE8e7HVfmw1h4sEYiCJ7H/3BK/08fEpVA7SZ4f6q
 P2SzC77qb4PGaSxbf7FW+lvcQ5EZRed+8jXaVzQYBD/cpZSliuD5or5xEC4tkuIzggBr
 sjSVBT2D6jxN6fNcxQqOEofZ1JaSImFyrP/AAN5QeOjuGctkibPcaO/Pu5R/9BcBSqjt
 oeuiUyjx1B1Fjef1rG8ne5MOKSzzk6/dcgQ19qyEt4Wi4bL3zQ7XRTx4apq4fJrEFPeg
 6lbQ==
X-Gm-Message-State: AOAM5338yT+9jnzo03uJetqY4+RUYbOLxQ+oI9ZYtW0sj4mE2Xr+/lnJ
 eWF8K4e/WWSKbf+9nUPIER9JqmCXP+TJ98TiIeM=
X-Google-Smtp-Source: ABdhPJzm4R8lZEEn221NAb8T8Cga2fRJ4OYFVFbtT2ObkNyhZPYsoujU//xyah6QakwHv0gM4t3Rjf8MuyeKnP+MY/o=
X-Received: by 2002:a92:5e48:: with SMTP id s69mr3202608ilb.199.1601670979218; 
 Fri, 02 Oct 2020 13:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201002201933.250878-1-jonatan.p@gmail.com>
 <c22a0594-9f8f-3531-cbc3-862ba15d89c9@redhat.com>
In-Reply-To: <c22a0594-9f8f-3531-cbc3-862ba15d89c9@redhat.com>
From: Jonatan Palsson <jonatan.p@gmail.com>
Date: Fri, 2 Oct 2020 22:36:07 +0200
Message-ID: <CAKm+giO8LQCw8g==0zKV2LYvfqxVmimnJ9oWcsdvFZtmPzcq_g@mail.gmail.com>
Subject: Re: [PATCH] scripts/qmp/qom-set: Allow setting integer value
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=jonatan.p@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 10:29 PM John Snow <jsnow@redhat.com> wrote:
>
> On 10/2/20 4:19 PM, Jonatan P=C3=A5lsson wrote:
> > If the value appears to be an integer, parse it as such.
> >
> > This allows the following:
> >
> >      qmp/qom-set -s ~/qmp.sock sensor.temperature 20000
> >
> > .. where sensor is a tmp105 device, and temperature is an integer
> > property.
> >
> > Signed-off-by: Jonatan P=C3=A5lsson <jonatan.p@gmail.com>
> > ---
> >   scripts/qmp/qom-set | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
> > index 240a78187f..61920680eb 100755
> > --- a/scripts/qmp/qom-set
> > +++ b/scripts/qmp/qom-set
> > @@ -56,7 +56,10 @@ if len(args) > 1:
> >           path, prop =3D args[0].rsplit('.', 1)
> >       except:
> >           usage_error("invalid format for path/property/value")
> > -    value =3D args[1]
> > +    try:
> > +        value =3D int(args[1])
> > +    except:
> > +        value =3D args[1]
>
> Please catch the ValueError explicitly.

Sure, I'll send a v2.

>
> >   else:
> >       usage_error("not enough arguments")
> >
> >
>
> What happens when you don't convert it to int specifically? Does
> something break? My understanding was that QOM received everything as a
> string anyway, and does its own parsing.

With the current implementation, I see this:

scripts/qmp/qom-set -s ~/qmp.sock sensor.temperature 20000
Traceback (most recent call last):
  File "scripts/qmp/qom-set", line 66, in <module>
    print(srv.command('qom-set', path=3Dpath, property=3Dprop, value=3Dvalu=
e))
  File "scripts/qmp/../../python/qemu/qmp.py", line 274, in command
    raise QMPResponseError(ret)
qemu.qmp.QMPResponseError: Invalid parameter type for 'temperature',
expected: integer

