Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5EEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF2020708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF2020708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnSK7-00032G-VG
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnSJT-0002UZ-03; Mon, 22 Jun 2020 15:41:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:53600
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnSJQ-0001uu-Ri; Mon, 22 Jun 2020 15:41:02 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnSJJ-0004yu-4p; Mon, 22 Jun 2020 20:40:59 +0100
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <35510ff8-b301-a3a1-48a6-ae5864007c49@ilande.co.uk>
 <d6a22c5f-2403-d6c4-da89-02e457ee0174@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <7cc68e37-e8d0-9d00-a0ca-725ee4b90486@ilande.co.uk>
Date: Mon, 22 Jun 2020 20:40:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d6a22c5f-2403-d6c4-da89-02e457ee0174@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: make test failure for iotest 267 on qemu-system-sparc64
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 10:25, Thomas Huth wrote:

>> After a recent rebase I've started seeing iotest 267 after running "make check" on
>> qemu-system-sparc64. The diff output looks similar to this:
>>
>> --- /home/build/src/qemu/git/qemu/tests/qemu-iotests/267.out    2020-01-22
>> 17:57:54.246650995 +0000
>> +++ /home/build/src/qemu/git/qemu/tests/qemu-iotests/267.out.bad        2020-03-07
>> 09:25:36.044451658 +0000
>> @@ -41,13 +41,7 @@
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>  Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device
>> virtio-blk,drive=none0
>>  QEMU X.Y.Z monitor - type 'help' for more information
>> -(qemu) savevm snap0
>> -(qemu) info snapshots
>> -List of snapshots present on all disks:
>> -ID        TAG                 VM SIZE                DATE       VM CLOCK
>> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>> -(qemu) loadvm snap0
>> -(qemu) quit
>> +(qemu) QEMU_PROG: -device virtio-blk,drive=none0: PCI: no slot/function available
>> for virtio-blk-pci, all in use or reserved
>>
>> The error message here is because the sun4u machine PCI root (default) bus contains
>> only 2 PCI bridges and cannot have devices plugged into it directly. An example of
>> how to use virtio-blk-pci on qemu-system-sparc64 is shown at
>> https://wiki.qemu.org/Documentation/Platforms/SPARC#All_PCI_devices_are_attached_behind_one_of_the_simba_PCI_bridges.
>>
>> It seems that all that is missing is a way to specify the bus= parameter for the
>> virtio-blk-pci device for this test to work. Can anyone suggest a suitable way to do
>> this?
> 
>  Hi!
> 
> Sorry for the late reply... but better late than never:

Heh, that's okay :)

> I think you likely don't want to change each and every current and
> future iotest to contain a "bus=..." parameter - that's not reasonable.
> So I see two possibilities to get "make check" working here again:
> 
> 1) From a user point of view, it would be great if PCI devices could be
> used on the sun4u machine also without specifying the "bus=..."
> property. Is there a way to convince QEMU to plug PCI devices in a
> different bus with free slots in case the root bus is already full? ...
> I had a quick look at the sources, but unfortunately I failed to spot
> the code that decides which PCI bus should be used in case no "bus=..."
> property has been specified, so no clue whether this is feasible or not.

It has been a while since I looked at this, but from memory the problem is that the
default bus value is 0 which matches the first (root) PCI bus. Which unfortunately
can't have anything plugged into it for sun4u.

Perhaps the QEMU machine needs a way to be able to override the id of the default PCI
bus which is used for -device?

> 2) Simply change the _require_devices function in
> tests/qemu-iotests/common.rc to filter out the virtio and pci devices on
> sparc64. Something like this should do the job, I hope:
> 
> diff a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -788,6 +788,11 @@ _require_devices()
>  {
>      available=$($QEMU -M none -device help | \
>                  grep ^name | sed -e 's/^name "//' -e 's/".*$//')
> +    case "$QEMU_PROG" in
> +        *qemu-system-sparc64)
> +            available=$(grep -v -i -E 'pci|virtio' <<< $available)
> +            ;;
> +    esac
>      for device
>      do
>          if ! echo "$available" | grep -q "$device" ; then

I'd prefer a solution that keeps the virtio tests if possible, since 5.0 is actually
broken for booting from a virtio-blk-pci device - there were a couple of changes
leading up to release that broke OpenBIOS (see
https://mail.coreboot.org/hyperkitty/list/openbios@openbios.org/2020/5/) that managed
to slip by.


ATB,

Mark.

