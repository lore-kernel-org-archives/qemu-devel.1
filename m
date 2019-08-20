Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B39C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B929222DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B929222DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05iD-0004JI-7O
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i05ev-0001c8-Lu
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i05eu-0006wm-7L
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i05et-0006wR-Vw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:02:52 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FB753CA21
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:02:51 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id s18so7168661wrt.21
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twunrK23FgStqjHyQ4d3oDo14s9HF68KPzisitr8IE4=;
 b=PRbY7EYEA1GCCHdqahhS1xrTBNfrdy0cV/LqD5bz0/yr1DTqDSTS8Tbxa1LBiXCIZn
 EH/oaG0oZxtX+q/5dP9XB06Y8qTENcYTnjPTcPCqM0AYVxqxNspD5tkBSXhEWY/FRp82
 tau8q6c/jwV+SiqaG1fkrxXlNFGNQKNfkWu6lkPA95uWN+DUsfvSk9mA/2Yvj3HQrBQR
 ZcZ5gp0Pf2h5fhSyZCq5u9yOLA7Eyq17PL99kWFcI18pGCM6YFVsLzkwcGvvKbiSdcJl
 mH9t9JbbVw710vSxhEZ6RJAVZNIttFYQikNKzaWzaGaV4VBsdhMjRTyrKf6CBotdEWNa
 MHfQ==
X-Gm-Message-State: APjAAAV61/uL08Jrf7wxFvxYgCnsZmf/p6/pFJWXp75852tgfQxmiv/V
 cAiagJqY8QBS06pTV0D7S0NX7CPve3Jfy9OV6XAOTeDfhGPXz99tcSi379mqxIC9sKUdENiL2eR
 8l/h9H36gY2UuLLI=
X-Received: by 2002:adf:93a4:: with SMTP id 33mr36317082wrp.187.1566313369768; 
 Tue, 20 Aug 2019 08:02:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw62XV5o6u1TN13p/aRP2eTQZ1cIeH1f1SDp1aq01y/5DIT+n9BlM1qUfG4PPWwAW6Tgmuh/A==
X-Received: by 2002:adf:93a4:: with SMTP id 33mr36317064wrp.187.1566313369575; 
 Tue, 20 Aug 2019 08:02:49 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z7sm16124133wrh.67.2019.08.20.08.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 08:02:49 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <1a45cee8-66e1-448d-78bc-4f0b9695cab4@redhat.com>
 <20190820143614.GJ2867@work-vm>
 <70fd81a1-08bb-5cc8-616c-68ec2a7472e2@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bbd48103-83cd-3b32-808b-fd788d0ec4dd@redhat.com>
Date: Tue, 20 Aug 2019 17:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <70fd81a1-08bb-5cc8-616c-68ec2a7472e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [SeaBIOS] Re: Regression with floppy drive
 controller
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
Cc: Alex <coderain@sdf.org>, Nikolay Nikolov <nickysn@users.sourceforge.net>,
 seabios@seabios.org, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Sorry seabios@ list for the noise!]

On 8/20/19 4:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/20/19 4:36 PM, Dr. David Alan Gilbert wrote:
>> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>>> On 8/20/19 3:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 8/20/19 3:12 PM, John Snow wrote:
>>>>> On 8/20/19 6:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> [cross posting QEMU & SeaBIOS]
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I'v been looking at a QEMU bug report [1] which bisection resulted=
 in a
>>>>>> SeaBIOS commit:
>>>>>>
>>>>>> 4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
>>>>>> commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
>>>>>> Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
>>>>>> Date:   Sun Feb 4 17:27:01 2018 +0200
>>>>>>
>>>>>>     floppy: Use timer_check() in floppy_wait_irq()
>>>>>>
>>>>>>     Use timer_check() instead of using floppy_motor_counter in BDA=
 for the
>>>>>>     timeout check in floppy_wait_irq().
>>>>>>
>>>>>>     The problem with using floppy_motor_counter was that, after it=
 reaches
>>>>>>     0, it immediately stops the floppy motors, which is not what i=
s
>>>>>>     supposed to happen on real hardware. Instead, after a timeout =
(like in
>>>>>>     the end of every floppy operation, regardless of the result - =
success,
>>>>>>     timeout or error), the floppy motors must be kept spinning for
>>>>>>     additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
>>>>>>     floppy_motor_counter is initialized to 255 (the max value) in =
the
>>>>>>     beginning of the floppy operation. For IRQ timeouts, a differe=
nt
>>>>>>     timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT const=
ant
>>>>>>     (currently set to 5 seconds - a fairly conservative value, but=
 should
>>>>>>     work reliably on most floppies).
>>>>>>
>>>>>>     After the floppy operation, floppy_drive_pio() resets the
>>>>>>     floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).
>>>>>>
>>>>>>     This is also consistent with what other PC BIOSes do.
>>>>>>
>>>>>>
>>>>>> This commit improve behavior with real hardware, so maybe QEMU is =
not
>>>>>> modelling something or modelling it incorrectly?
> [...]
>>> Looking at the fdc timer I noticed it use a static '50 ns' magic valu=
e.
>>
>> That's not 50ns
>>
>>> Increasing this value allows the floppy image to boot again, using th=
is
>>> snippet:
>>>
>>> -- >8 --
>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>> index 9b24cb9b85..5fc54073fd 100644
>>> --- a/hw/block/fdc.c
>>> +++ b/hw/block/fdc.c
>>> @@ -2134,7 +2134,7 @@ static void fdctrl_handle_readid(FDCtrl *fdctrl=
,
>>> int direction)
>>>
>>>      cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
>>>      timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIR=
TUAL) +
>>> -             (NANOSECONDS_PER_SECOND / 50));
>>
>> That's 1/50th of a second in ns.
>=20
> Just noticed that too, so we have here 20ms.
>=20
>>> +             (NANOSECONDS_PER_SECOND / 5000));
>>
>> I'm not too sure about readid; but assuming we're rotating at 360rpm,
>> that's 6 revolutions/second, and 18 sectors/track =3D 108 sectors/seco=
nd
>> (half of that for a double density disk).
>>
>> So, the wait for a sector to spin around and read feels like it should
>> be in the region of 1/108 of a second + some latency - so 1/50th of a
>> second would seem to be in the ballpark or being right, where as 1/500=
0
>> of a second is way too fast for a poor old floppy.
>=20
> The first command sent is READ_ID.
>=20
> Reading the Intel 82077AA datasheet:
>=20
>   The READ ID command is used to find the present
>   position of the recording heads. The 82077AA
>   stores the values from the first ID Field it is able to
>   read into its registers. If the 82077AA does not find
>   an ID Address Mark on the diskette after the second
>   occurrence of a pulse on the IDX pin, it then sets the
>   IC code in Status Register 0 to =E2=80=98=E2=80=9801=E2=80=99=E2=80=99=
 (Abnormal ter-
>   mination), sets the MA bit in Status Register 1 to
>   =E2=80=98=E2=80=991=E2=80=99=E2=80=99, and terminates the command.
>=20
> Then later the SPECIFICATIONS table:
>=20
>   nRD/nWR Pulse Width: min 90ns
>   INDEX Pulse Width: min 5 'Internal Clock Period'
>=20
>   The nominal values for the 'internal clock period' for the various
>   data rates are:
>=20
>     1 Mbps:  3 * osc period =3D 125ns
>   500 Kbps:  6 * osc period =3D 250ns
>   300 Kbps: 10 * osc period =3D 420ns
>   250 Kbps: 12 * osc period =3D 500ns
>=20
> IIUC the model we have DATARATE SELECT REGISTER (DSR) =3D 0
>=20
> So DRATESEL=3D0 =3D> datarate =3D 500 Kbps
>=20
> So we should wait at least 250ns.
>=20
> Trying the following snippet it also works:
>=20
> -- >8 --
> @@ -2133,8 +2133,8 @@ static void fdctrl_handle_readid(FDCtrl *fdctrl,
> int direction)
>      FDrive *cur_drv =3D get_cur_drv(fdctrl);
>=20
>      cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
> -    timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) +
> -             (NANOSECONDS_PER_SECOND / 50));
> +    timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL)
> +                                    + 250);
>  }
> ---
>=20
> Note this is not the spining-up delay on reset:
>=20
>   Before data can be transferred to or from the disk-
>   ette, the disk drive motor must be brought up to
>   speed. For most 3(/2 =C3=97 disk drives, the spin-up time is
>   300 ms, while the 5(/4 =C3=97 drive usually requires about
>   500 ms due to the increased moment of inertia asso-
>   ciated with the larger diameter diskette.
>=20
> This looks more closer to the 20ms order. So maybe what we miss
> here is a RESET delay (of 500ms?) previous to the READ_ID?

From the datasheet:

  After the motor has been turned on, the matching
  data rate for the media inserted into the disk drive
  should then be programmed to the 82077AA via the
  Configuration Control Register (CCR). The 82077AA
  is designed to allow a different data rate to be pro-
  grammed arbitrarily without disrupting the integrity of
  the device. In some applications, it is required to au-
  tomatically determine the recorded data rate of the
  inserted media. One technique for doing this is to
  perform a READ ID operation at each available data
  rate until a successful status is returned in the result
  phase.

However QEMU doesn't model this delay:

static void fdctrl_result_timer(void *opaque)
{
    FDCtrl *fdctrl =3D opaque;
    FDrive *cur_drv =3D get_cur_drv(fdctrl);

    /* Pretend we are spinning.
     * This is needed for Coherent, which uses READ ID to check for
     * sector interleaving.
     */

So latest snippet could be OK.

