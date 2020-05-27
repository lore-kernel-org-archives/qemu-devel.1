Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E57D20C56
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E57D20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqsQ-0003Ek-FT
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqrG-0001RG-J7
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:52:14 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqrF-0005L4-F4
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:52:14 -0400
Received: by mail-ej1-f68.google.com with SMTP id y13so4898700eju.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V8/R3XDOhv+EBwJfIsEGBrb3ekCpboZGCo3efFZDEcY=;
 b=kkxtTOFWTqKDtluk3Z5lJgawQCcimUpDHGm14tWtjcGa+GJD5MnkbVbkIxfft+23Jg
 svvuSpZqtAynEUI75nq0t5hLCc5ePqOoNF++wHYQRy+3Z6wy2W2/CkfBPygaXZ7WQbpr
 OkLnXyVfNTcjsxVDSrpHOnQEpiRjBxh02qnLlKVlw3Mfx9lc4sFlhI3GdD+YgdEHLvS/
 JMcL3HQawAbS0QbvPinGBl1/xOyNIQWY5Op28/IwtlidAEG0FpB7br2tpY9Jzo/C4fpG
 4TkA7UKD1LPrJ6gigR+3ve8pA87fASYlXn6KqYmE1pLXe99OyghAsX0jb7lusIa/sx7i
 DL+A==
X-Gm-Message-State: AOAM531R8a4FggjmO2gIWVfOBumDtJoTtcWoIzsa4X7SuuEolOrk6M91
 hKr268E4k2LNL5IquFQx/JfQ0bK7Ylz9BQgN/1E=
X-Google-Smtp-Source: ABdhPJxyUTmNMh3NwJPhMGhr3g/4gWVZBsM/hGaN+AgdhC/2WtIpd3tCjqkyKuXCxtb3lXjoSLCDEhkdhYEg6qz+QOY=
X-Received: by 2002:a17:906:9404:: with SMTP id
 q4mr4675249ejx.138.1590565932008; 
 Wed, 27 May 2020 00:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
 <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
 <CAHiYmc6DMA2LRXama80zaPi+7RqFQYWL5OwtRn_Xk-ueASAi_A@mail.gmail.com>
 <3cc6c3d2-19f6-8502-a460-67c5853ff953@amsat.org>
 <CAHiYmc6xuRQ0u+BLotEpKvmF+_vv2madz80oUJqsJz0o3a3JdA@mail.gmail.com>
In-Reply-To: <CAHiYmc6xuRQ0u+BLotEpKvmF+_vv2madz80oUJqsJz0o3a3JdA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 27 May 2020 09:52:00 +0200
Message-ID: <CAAdtpL7ROfxW-LVMzUjnAOogmvHunPZ+tppX-OwuEO7+7uj=5Q@mail.gmail.com>
Subject: Re: [PATCH v6 20/21] hw/mips: Add some logging for bad register
 offset cases
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 03:52:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On Tue, May 26, 2020 at 12:46 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:38 Philippe Ma=
thieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > On 5/26/20 12:05 PM, Aleksandar Markovic wrote:
> > > =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 09:42 Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >>
> > >> On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> > >>> Log the cases where a guest attempts read or write using bad
> > >>> register offset.
> > >>>
> > >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>
> > >> Not well tested apparently, because it doesn't build with GCC 5.4.0
> > >> (Ubuntu):
> > >>
> > >> hw/mips/malta.c: In function =E2=80=98malta_fpga_read=E2=80=99:
> > >> hw/mips/malta.c:430:85: error: format =E2=80=98%x=E2=80=99 expects a=
rgument of type
> > >> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwa=
ddr {aka long unsigned int}=E2=80=99
> > >> [-Werror=3Dformat=3D]
> > >> hw/mips/malta.c: In function =E2=80=98malta_fpga_write=E2=80=99:
> > >> hw/mips/malta.c:517:85: error: format =E2=80=98%x=E2=80=99 expects a=
rgument of type
> > >> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwa=
ddr {aka long unsigned int}=E2=80=99
> > >> [-Werror=3Dformat=3D]
> > >> cc1: all warnings being treated as errors
> > >>
> > >> I amended this snippet ...:
> > >>
> > >> -- >8 --
> > >> @@ -428,8 +428,8 @@ static uint64_t malta_fpga_read(void *opaque, hw=
addr
> > >> addr,
> > >>
> > >>      default:
> > >>          qemu_log_mask(LOG_GUEST_ERROR,
> > >> -                      "malta_fpga_read: Bad register offset 0x"
> > >> -                      TARGET_FMT_lx "\n", addr);
> > >> +                      "malta_fpga_read: Bad register addr
> > >> 0x%"HWADDR_PRIX"\n",
> > >> +                      addr);
> > >>          break;
> > >>      }
> > >>      return val;
> > >> @@ -515,8 +515,8 @@ static void malta_fpga_write(void *opaque, hwadd=
r addr,
> > >>
> > >>      default:
> > >>          qemu_log_mask(LOG_GUEST_ERROR,
> > >> -                      "malta_fpga_write: Bad register offset 0x"
> > >> -                      TARGET_FMT_lx "\n", addr);
> > >> +                      "malta_fpga_write: Bad register addr
> > >> 0x%"HWADDR_PRIX"\n",
> > >> +                      addr);
> > >>          break;
> > >>      }
> > >>  }
> > >> ---
> > >>
> > >> ... and queued to mips-next,
> > >>
> > >
> > > Hi, Philippe,
> > >
> > > Many thanks for correcting my mistake in this patch!
> > > May I ask you to refer to your queue as hw/mips-next, rather than
> > > mips-next, for the sake of clarity?
> >
> > Tags with '/' are hard to manage, let's use mips-hw-next,
> > mips-target-next for your pull requests and mips-kvm-next for Huacai's =
ones.
> >
> > > And, when do you plan to send the pull request?
> >
> > Waiting for Gerd's audio-next one to get merged because he took my
> > "mips_fulong2e: Remove unused 'audio/audio.h' include" patch and I don'=
t
> > want Peter to have to manually resolve conflicts (there shouldn't be,
> > but I don't want to risk bother him with a "automatic 3-way merge" warn=
ing).
> >
>
> Philippe, I think you created a lot of problems here without any real nee=
d.

Did I?

>
> We should sync between us rather than sent "surprise" "pull requests".

This I clearly understood. I doubt this will ever happen again.

>
> I am not happy with coordination of our common MIPS work.

I am also unhappy with my MIPS contributions.

Regards,

Phil.

>
> > >
> > > Thanks,
> > > Aleksandar
> > >
> > >
> > >> Thanks,
> > >>
> > >> Phil.
> > >>
> > >>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
> > >>> ---
> > >>>  hw/mips/mips_malta.c | 14 ++++++--------
> > >>>  1 file changed, 6 insertions(+), 8 deletions(-)
> > >>>
> > >>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > >>> index e4c4de1b4e..88869b828e 100644
> > >>> --- a/hw/mips/mips_malta.c
> > >>> +++ b/hw/mips/mips_malta.c
> > >>> @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, =
hwaddr addr,
> > >>>          break;
> > >>>
> > >>>      default:
> > >>> -#if 0
> > >>> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FM=
T_lx "\n",
> > >>> -               addr);
> > >>> -#endif
> > >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> > >>> +                      "malta_fpga_read: Bad register offset 0x"
> > >>> +                      TARGET_FMT_lx "\n", addr);
> > >>>          break;
> > >>>      }
> > >>>      return val;
> > >>> @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwa=
ddr addr,
> > >>>          break;
> > >>>
> > >>>      default:
> > >>> -#if 0
> > >>> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_F=
MT_lx "\n",
> > >>> -               addr);
> > >>> -#endif
> > >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> > >>> +                      "malta_fpga_write: Bad register offset 0x"
> > >>> +                      TARGET_FMT_lx "\n", addr);
> > >>>          break;
> > >>>      }
> > >>>  }
> > >>>
> > >

