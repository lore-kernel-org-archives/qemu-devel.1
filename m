Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984CEC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71300217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71300217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ize1v-0007B1-Ls
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ize0A-0006ce-Vq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ize08-0007Ao-J2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:03:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ize04-0006jL-Up; Thu, 06 Feb 2020 05:03:09 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOAmt-1jAKI20LGb-00OY9s; Thu, 06 Feb 2020 11:03:03 +0100
Subject: Re: [PATCH] hw/i386/vmmouse: Fix crash when using the vmmouse on a
 machine without vmport
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20200129112954.4282-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <6f5abb31-7b4b-7ffd-ce08-edbc8ba96845@vivier.eu>
Date: Thu, 6 Feb 2020 11:03:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200129112954.4282-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b9TXFAkYUh1iWgIVrl48m4Dklwt6SOCkdLjSzsGuwO+MPhZY9BB
 FWkAZ/YpvGZtcGdcmrst4hvvz9/H3YvPjAdOpmsMTbx1HvDhm08dWspiE0NbWHPWeh3Zu6K
 qoO0PA2sbFJVK+yeBBuu7DDFKZ2VwP7uoiGFqgPVp5eH4/AUjdfTSXxmYwbz5RD8V+GrjnT
 NNhtI8fabGAerDT1z576w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DIVCMzgIVos=:XKCUWbujWNMj216c9EQdK3
 Mj7qFo6hKXv4apejbZcKwEz5Oe6we7YLrJx6rjiJM4zlgjGWP9tl6tHKkF6zAdbR1b0y/2dp4
 Cu+IVhjV38Mpy4gGYb8nCcIx1DGQv/hfXtN/FFJ5tPcJ6BUlH+M0CmS4+ndNuRUrcHDg98UgJ
 XXMDJbwz7hUOrd2nqeSaGE3DJX627sZIDgfD7OOCt8giKD1jxo3rdWnTE024b3xFGpF2P3RVJ
 Bypcshna5VQpr1qQ8CSs5p3SP8SZ9AB67mTqtRiPPuG64ip0qYOenJmuusvIIk3ZAdjFX3gtD
 KQ4Ixza+TzwJYZ/TwzAWljv5JhCAA4V2clMLqeTIdtfEYRK20W3aIOVoTwalK4cKdtoAJMBhR
 tC6RDd64IvNJYxNqYznrz5ETcKd/JF/hkERCREg8fsJ7H7NQPY0dsep/T1J5ale5ohHJvLYdW
 oOW0HJSvDVjVzHumzz6inG+JFVBn7DztUE8lxEy0SFMOExOo/vA7Z9nKMRAHEZtNm34ojvJXK
 z/4dE476uMs3NtgghDUHQPCRjVCrf848izP8UIA2YTcWh7CCSpqYgOArWOkFZuaQKJvseS+Ax
 tAaACQKVTWUxFuRzDlhFegpTeHEaxiCHqTqmuUkl6qd9/oyx+qpPJ696cQJ1SV+a4bFtR1ZZt
 2XsB3j+lCWdSrjP4yfeQd5kJQL/do7dcWZdPDkUO1HBbC39QaNbeUyKNUMjX6zSyXTKHk7YVX
 AHn5yWugMfQX3TARKm84M1T9gTEDMweX/zY0r9vpLRoQ5fvMu+GBpr8TWR/MKMHbBnUYaIhW+
 rO/7qcjIbAhVmMHo4kuuTWIms25mTmeh1vRzBTJ6xOttf1/rI9/VETHUF9ezPYJmoQntFNB
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/01/2020 à 12:29, Thomas Huth a écrit :
> QEMU currently crashes when the user tries to use the "vmmouse" on a
> machine without vmport, e.g.:
> 
>  $ x86_64-softmmu/qemu-system-x86_64 -machine microvm -device vmmouse
>  Segmentation fault (core dumped)
> 
> or:
> 
>  $ x86_64-softmmu/qemu-system-x86_64 -device vmmouse -M pc,vmport=off
>  Segmentation fault (core dumped)
> 
> Let's avoid the crash by checking for the vmport device first.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/vmmouse.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 7c2a375527..e8e62bd96b 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "ui/console.h"
>  #include "hw/i386/pc.h"
>  #include "hw/input/i8042.h"
> @@ -269,6 +270,11 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
>  
>      DPRINTF("vmmouse_init\n");
>  
> +    if (!object_resolve_path_type("", TYPE_VMPORT, NULL)) {
> +        error_setg(errp, "vmmouse needs a machine with vmport");
> +        return;
> +    }
> +
>      vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
>      vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
>      vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

