Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEF420A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEF420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMtcX-0007sY-48
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Brice.Goglin@inria.fr>) id 1jMtbh-0007QU-Cx
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Brice.Goglin@inria.fr>) id 1jMtbf-0005wc-Bg
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:22:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:50715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Brice.Goglin@inria.fr>)
 id 1jMtbe-0005vv-T8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:22:03 -0400
X-IronPort-AV: E=Sophos;i="5.72,366,1580770800"; 
 d="scan'208,217";a="345608472"
Received: from 91-160-5-165.subs.proxad.net (HELO [192.168.44.21])
 ([91.160.5.165])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Apr 2020 15:21:53 +0200
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
 <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
 <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
From: Brice Goglin <Brice.Goglin@inria.fr>
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 mQINBFNg91oBEADMfOyfz9iilNPe1Yy3pheXLf5O/Vpr+gFJoXcjA80bMeSWBf4on8Mt5Fg/
 jpVuNBhii0Zyq4Lip1I2ve+WQjfL3ixYQqvNRLgfw/FL0gNHSOe9dVFo0ol0lT+vu3AXOVmh
 AM4IrsOp2Tmt+w89Oyvu+xwHW54CJX3kXp4c7COz79A6OhbMEPQUreerTavSvYpH5pLY55WX
 qOSdjmlXD45yobQbMg9rFBy1BECrj4DJSpym/zJMFVnyC5yAq2RdPFRyvYfS0c491adD/iw9
 eFZY1XWj+WqLSW8zEejdl78npWOucfin7eAKvov5Bqa1MLGS/2ojVMHXJN0qpStpKcueV5Px
 igX8i4O4pPT10xCXZ7R6KIGUe1FE0N7MLErLvBF6AjMyiFHix9rBG0pWADgCQUUFjc8YBKng
 nwIKl39uSpk5W5rXbZ9nF3Gp/uigTBNVvaLO4PIDw9J3svHQwCB31COsUWS1QhoLMIQPdUkk
 GarScanm8i37Ut9G+nB4nLeDRYpPIVBFXFD/DROIEfLqOXNbGwOjDd5RWuzA0TNzJSeOkH/0
 qYr3gywjiE81zALO3UeDj8TaPAv3Dmu7SoI86Bl7qm6UOnSL7KQxZWuMTlU3BF3d+0Ly0qxv
 k1XRPrL58IyoHIgAVom0uUnLkRKHczdhGDpNzsQDJaO71EPp8QARAQABtCRCcmljZSBHb2ds
 aW4gPEJyaWNlLkdvZ2xpbkBpbnJpYS5mcj6JAjgEEwECACIFAlNg+aMCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEESRkPMjWr076RoQAJhJ1q5+wlHIf+YvM0N1V1hQyf+aL35+
 BPqxlyw4H65eMWIN/63yWhcxrLwNCdgY1WDWGoiW8KVCCHwJAmrXukFvXjsvShLQJavWRgKH
 eea12T9XtLc6qY/DEi2/rZvjOCKsMjnc1CYW71jbofaQP6lJsmC+RPWrnL/kjZyVrVrg7/Jo
 GemLmi/Ny7nLAOt6uL0MC/Mwld14Yud57Qz6VTDGSOvpNacbkJtcCwL3KZDBfSDnZtSbeclY
 srXoMnFXEJJjKJ6kcJrZDYPrNPkgFpSId/WKJ5pZBoRsKH/w2OdxwtXKCYHksMCiI4+4fVFD
 WlmVNYzW8ZKXjAstLh+xGABkLVXs+0WjvC67iTZBXTmbYJ5eodv8U0dCIR/dxjK9wxVKbIr2
 D+UVbGlfqUuh1zzL68YsOg3L0Xc6TQglKVl6RxX87fCU8ycIs9pMbXeRDoJohflo8NUDpljm
 zqGlZxBjvb40p37ReJ+VfjWqAvVh+6JLaMpeva/2K1Nvr9O/DOkSRNetrd86PslrIwz8yP4l
 FaeG0dUwdRdnToNz6E8lbTVOwximW+nwEqOZUs1pQNKDejruN7Xnorr7wVBfp6zZmFCcmlw9
 8pSMV3p85wg6nqJnBkQNTzlljycBvZLVvqc6hPOSXpXf5tjkuUVWgtbCc8TDEQFx8Phkgda6
 K1LNuQINBFNg91oBEADp3vwjw8tQBnNfYJNJMs6AXC8PXB5uApT1pJ0fioaXvifPNL6gzsGt
 AF53aLeqB7UXuByHr8Bmsz7BvwA06XfXXdyLQP+8Oz3ZnUpw5inDIzLpRbUuAjI+IjUtguIK
 AkU1rZNdCXMOqEwCaomRitwaiX9H7yiDTKCUaqx8yAuAQWactWDdyFii2FA7IwVlD/GBqMWV
 weZsMfeWgPumKB3jyElm1RpkzULrtKbu7MToMH2fmWqBtTkRptABkY7VEd8qENKJBZKJGisk
 Fk6ylp8VzZdwbAtEDDTGK00Vg4PZGiIGbQo8mBqbc63DY+MdyUEksTTu2gTcqZMm/unQUJA8
 xB4JrTAyljo/peIt6lsQa4+/eVolfKL1t1C3DY8f4wMoqnZORagnWA2oHsLsYKvcnqzA0QtY
 IIb1S1YatV+MNMFf3HuN7xr/jWlfdt59quXiOHU3qxIzXJo/OfC3mwNW4zQWJkG233UOf6YE
 rmrSaTIBTIWF8CxGY9iXPaJGNYSUa6R/VJS09EWeZgRz9Gk3h5AyDrdo5RFN9HNwOj41o0cj
 eLDF69092Lg5p5isuOqsrlPi5imHKcDtrXS7LacUI6H0c8onWoH9LuW99WznEtFgPJg++TAv
 f9M2x57Gzl+/nYTB5/Kpl1qdPPC91zUipiKbnF5f8bQpol0WC+ovmQARAQABiQIfBBgBAgAJ
 BQJTYPdaAhsMAAoJEESRkPMjWr074+0P/iEcN27dx3oBTzoeGEBhZUVQRZ7w4A61H/vW8oO8
 IPkZv9kFr5pCfIonmHEbBlg6yfjeHXwF5SF2ywWRKkRsFHpaFWywxqk9HWXu8cGR1pFsrwC3
 EdossuVbEFNmhjHvcAo11nJ7JFzPTEnlPjE6OY9tEDwl+kp1WvyXqNk9bosaX8ivikhmhB47
 7BA3Kv8uUE7UL6p7CBdqumaOFISi1we5PYE4P/6YcyhQ9Z2wH6ad2PpwAFNBwxSu+xCrVmaD
 skAwknf6UVPN3bt67sFAaVgotepx6SPhBuH4OSOxVHMDDLMu7W7pJjnSKzMcAyXmdjON05Sz
 SaILwfceByvHAnvcFh2pXK9U4E/SyWZDJEcGRRt79akzZxls52stJK/2Tsr0vKtZVAwogiaK
 uSp+m6BRQcVVhTo/Kq3E0tSnsTHFeIO6QFHKJCJv4FRE3Dmtz15lueihUBowsq9Hk+u3UiLo
 SmrMAZ6KgA4SQxB2p8/M53kNJl92HHc9nc//aCQDi1R71NyhtSx+6PyivoBkuaKYs+S4pHmt
 sFE+5+pkUNROtm4ExLen4N4OL6Kq85mWGf2f6hd+OWtn8we1mADjDtdnDHuv+3E3cacFJPP/
 wFV94ZhqvW4QcyBWcRNFA5roa7vcnu/MsCcBoheR0UdYsOnJoEpSZswvC/BGqJTkA2sf
Message-ID: <5ffb4cc2-f397-28b1-ec63-eb9d606439cf@inria.fr>
Date: Fri, 10 Apr 2020 15:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------EDA9B5031FBABED6A5E3CD06"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
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
Cc: Ludovic Courtes <ludovic.courtes@inria.fr>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EDA9B5031FBABED6A5E3CD06
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Le 10/04/2020 à 14:33, Alex Bennée a écrit :
> That was by inspection on my system which seems to truncate a lot
> earlier. It would be nice to find where in the Linux kernel it is
> output but I failed to grep the relevant function last night.


It's in proc/array.c, do_task_stat() calls proc_task_name(). In the end,
it seems to use task->tcomm or task->comm which is limited by

#define TASK_COMM_LEN			16

Brice



>
> On Fri, 10 Apr 2020, 12:11 Philippe Mathieu-Daudé, <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
>
>     Cc'ing Ludovic in case he can test with Guix-HPC.
>
>     On 4/9/20 11:15 PM, Alex Bennée wrote:
>     > In the original bug report long files names in Guix caused
>     > /proc/self/stat be truncated without the trailing ") " as
>     specified in
>     > proc manpage which says:
>     >      (2) comm  %s
>     >             The  filename of the executable, in parentheses.  This
>     >             is visible whether or not the  executable  is  swapped
>     >             out.
>     >
>     > Additionally it should only be reporting the executable name rather
>     > than the full path. Fix both these failings while cleaning up
>     the code
>     > to use GString to build up the reported values. As the whole
>     function
>     > is cleaned up also adjust the white space to the current coding
>     style.
>     >
>     > Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr
>     <mailto:fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>>
>     > Reported-by: Brice Goglin <Brice.Goglin@inria.fr
>     <mailto:Brice.Goglin@inria.fr>>
>     > Cc: Philippe_Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     > Signed-off-by: Alex Bennée <alex.bennee@linaro.org
>     <mailto:alex.bennee@linaro.org>>
>     > ---
>     >   linux-user/syscall.c | 43
>     +++++++++++++++++++------------------------
>     >   1 file changed, 19 insertions(+), 24 deletions(-)
>     >
>     > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>     > index 6495ddc4cda..674f70e70a5 100644
>     > --- a/linux-user/syscall.c
>     > +++ b/linux-user/syscall.c
>     > @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env,
>     int fd)
>     >   {
>     >       CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
>     >       TaskState *ts = cpu->opaque;
>     > -    abi_ulong start_stack = ts->info->start_stack;
>     > +    g_autoptr(GString) buf = g_string_new(NULL);
>     >       int i;
>     >   
>     >       for (i = 0; i < 44; i++) {
>     > -      char buf[128];
>     > -      int len;
>     > -      uint64_t val = 0;
>     > -
>     > -      if (i == 0) {
>     > -        /* pid */
>     > -        val = getpid();
>     > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>     > -      } else if (i == 1) {
>     > -        /* app name */
>     > -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>     > -      } else if (i == 27) {
>     > -        /* stack bottom */
>     > -        val = start_stack;
>     > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>     > -      } else {
>     > -        /* for the rest, there is MasterCard */
>     > -        snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n' : ' ');
>     > -      }
>     > +        if (i == 0) {
>     > +            /* pid */
>     > +            g_string_printf(buf, FMT_pid " ", getpid());
>     > +        } else if (i == 1) {
>     > +            /* app name */
>     > +            gchar *bin = g_strrstr(ts->bprm->argv[0], "/");
>     > +            bin = bin ? bin + 1 : ts->bprm->argv[0];
>     > +            g_string_printf(buf, "(%.15s) ", bin);
>
>     15 or 125? 15 seems short. From your previous test I understood it
>     was
>     124, for
>     sizeof("cat_with9_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890___40").
>
>     > +        } else if (i == 27) {
>     > +            /* stack bottom */
>     > +            g_string_printf(buf, TARGET_ABI_FMT_ld " ",
>     ts->info->start_stack);
>     > +        } else {
>     > +            /* for the rest, there is MasterCard */
>     > +            g_string_printf(buf, "0%c", i == 43 ? '\n' : ' ');
>     > +        }
>     >   
>     > -      len = strlen(buf);
>     > -      if (write(fd, buf, len) != len) {
>     > -          return -1;
>     > -      }
>     > +        if (write(fd, buf->str, buf->len) != buf->len) {
>     > +            return -1;
>     > +        }
>     >       }
>     >   
>     >       return 0;
>     >
>

--------------EDA9B5031FBABED6A5E3CD06
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Le 10/04/2020 à 14:33, Alex Bennée a
      écrit :<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">That was by inspection on my system which seems to
        truncate a lot earlier. It would be nice to find where in the
        Linux kernel it is output but I failed to grep the relevant
        function last night.</div>
    </blockquote>
    <p><br>
    </p>
    <p>It's in proc/array.c, do_task_stat() calls proc_task_name(). In
      the end, it seems to use task-&gt;tcomm or task-&gt;comm which is
      limited by <br>
    </p>
    <pre>#define TASK_COMM_LEN			16</pre>
    <p>Brice</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com"><br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, 10 Apr 2020, 12:11
          Philippe Mathieu-Daudé, &lt;<a href="mailto:philmd@redhat.com"
            moz-do-not-send="true">philmd@redhat.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Cc'ing
          Ludovic in case he can test with Guix-HPC.<br>
          <br>
          On 4/9/20 11:15 PM, Alex Bennée wrote:<br>
          &gt; In the original bug report long files names in Guix
          caused<br>
          &gt; /proc/self/stat be truncated without the trailing ") " as
          specified in<br>
          &gt; proc manpage which says:<br>
          &gt;      (2) comm  %s<br>
          &gt;             The  filename of the executable, in
          parentheses.  This<br>
          &gt;             is visible whether or not the  executable 
          is  swapped<br>
          &gt;             out.<br>
          &gt; <br>
          &gt; Additionally it should only be reporting the executable
          name rather<br>
          &gt; than the full path. Fix both these failings while
          cleaning up the code<br>
          &gt; to use GString to build up the reported values. As the
          whole function<br>
          &gt; is cleaned up also adjust the white space to the current
          coding style.<br>
          &gt; <br>
          &gt; Message-ID: &lt;<a
            href="mailto:fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr"
            target="_blank" rel="noreferrer" moz-do-not-send="true">fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr</a>&gt;<br>
          &gt; Reported-by: Brice Goglin &lt;<a
            href="mailto:Brice.Goglin@inria.fr" target="_blank"
            rel="noreferrer" moz-do-not-send="true">Brice.Goglin@inria.fr</a>&gt;<br>
          &gt; Cc: Philippe_Mathieu-Daudé &lt;<a
            href="mailto:philmd@redhat.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true">philmd@redhat.com</a>&gt;<br>
          &gt; Signed-off-by: Alex Bennée &lt;<a
            href="mailto:alex.bennee@linaro.org" target="_blank"
            rel="noreferrer" moz-do-not-send="true">alex.bennee@linaro.org</a>&gt;<br>
          &gt; ---<br>
          &gt;   linux-user/syscall.c | 43
          +++++++++++++++++++------------------------<br>
          &gt;   1 file changed, 19 insertions(+), 24 deletions(-)<br>
          &gt; <br>
          &gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
          &gt; index 6495ddc4cda..674f70e70a5 100644<br>
          &gt; --- a/linux-user/syscall.c<br>
          &gt; +++ b/linux-user/syscall.c<br>
          &gt; @@ -7295,34 +7295,29 @@ static int open_self_stat(void
          *cpu_env, int fd)<br>
          &gt;   {<br>
          &gt;       CPUState *cpu = env_cpu((CPUArchState *)cpu_env);<br>
          &gt;       TaskState *ts = cpu-&gt;opaque;<br>
          &gt; -    abi_ulong start_stack = ts-&gt;info-&gt;start_stack;<br>
          &gt; +    g_autoptr(GString) buf = g_string_new(NULL);<br>
          &gt;       int i;<br>
          &gt;   <br>
          &gt;       for (i = 0; i &lt; 44; i++) {<br>
          &gt; -      char buf[128];<br>
          &gt; -      int len;<br>
          &gt; -      uint64_t val = 0;<br>
          &gt; -<br>
          &gt; -      if (i == 0) {<br>
          &gt; -        /* pid */<br>
          &gt; -        val = getpid();<br>
          &gt; -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);<br>
          &gt; -      } else if (i == 1) {<br>
          &gt; -        /* app name */<br>
          &gt; -        snprintf(buf, sizeof(buf), "(%s) ",
          ts-&gt;bprm-&gt;argv[0]);<br>
          &gt; -      } else if (i == 27) {<br>
          &gt; -        /* stack bottom */<br>
          &gt; -        val = start_stack;<br>
          &gt; -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);<br>
          &gt; -      } else {<br>
          &gt; -        /* for the rest, there is MasterCard */<br>
          &gt; -        snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n'
          : ' ');<br>
          &gt; -      }<br>
          &gt; +        if (i == 0) {<br>
          &gt; +            /* pid */<br>
          &gt; +            g_string_printf(buf, FMT_pid " ", getpid());<br>
          &gt; +        } else if (i == 1) {<br>
          &gt; +            /* app name */<br>
          &gt; +            gchar *bin =
          g_strrstr(ts-&gt;bprm-&gt;argv[0], "/");<br>
          &gt; +            bin = bin ? bin + 1 :
          ts-&gt;bprm-&gt;argv[0];<br>
          &gt; +            g_string_printf(buf, "(%.15s) ", bin);<br>
          <br>
          15 or 125? 15 seems short. From your previous test I
          understood it was <br>
          124, for <br>
sizeof("cat_with9_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890___40").<br>
          <br>
          &gt; +        } else if (i == 27) {<br>
          &gt; +            /* stack bottom */<br>
          &gt; +            g_string_printf(buf, TARGET_ABI_FMT_ld " ",
          ts-&gt;info-&gt;start_stack);<br>
          &gt; +        } else {<br>
          &gt; +            /* for the rest, there is MasterCard */<br>
          &gt; +            g_string_printf(buf, "0%c", i == 43 ? '\n' :
          ' ');<br>
          &gt; +        }<br>
          &gt;   <br>
          &gt; -      len = strlen(buf);<br>
          &gt; -      if (write(fd, buf, len) != len) {<br>
          &gt; -          return -1;<br>
          &gt; -      }<br>
          &gt; +        if (write(fd, buf-&gt;str, buf-&gt;len) !=
          buf-&gt;len) {<br>
          &gt; +            return -1;<br>
          &gt; +        }<br>
          &gt;       }<br>
          &gt;   <br>
          &gt;       return 0;<br>
          &gt; <br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------EDA9B5031FBABED6A5E3CD06--

