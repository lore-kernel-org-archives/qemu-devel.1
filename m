Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57D82067B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 02:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D82067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji78N-0007ts-15
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 22:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ji77l-0007U8-UB
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 22:02:53 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1ji77j-0004Eg-F7
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 22:02:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436965|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00244832-0.000129292-0.997422;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HjRsr67_1591581761; 
Received: from 30.225.208.60(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HjRsr67_1591581761)
 by smtp.aliyun-inc.com(10.147.41.231);
 Mon, 08 Jun 2020 10:02:41 +0800
Subject: Re: hw/char: a question about watch callback function in serial
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <81607772-7cbc-1d61-2687-313f6389e1eb@c-sky.com>
 <CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com>
 <7eb57b4e-8d74-38c2-b8fd-00b6e2e99975@c-sky.com>
Message-ID: <00b54339-4c97-9ec5-5ce2-e57da2927fda@c-sky.com>
Date: Mon, 8 Jun 2020 10:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7eb57b4e-8d74-38c2-b8fd-00b6e2e99975@c-sky.com>
Content-Type: multipart/alternative;
 boundary="------------B0241B05D7EA495B74B2B7F6"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 22:02:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 UNPARSEABLE_RELAY=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------B0241B05D7EA495B74B2B7F6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/5 10:19, LIU Zhiwei wrote:
>
>
> On 2020/6/4 21:32, Peter Maydell wrote:
>> On Thu, 4 Jun 2020 at 13:15, LIU Zhiwei<zhiwei_liu@c-sky.com>  wrote:
>>> I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback function.
>>>
>>> In hw/serial.c, it is serial_watch_cb, setting by the following code,
>>>
>>>    s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>>>
>>>                        serial_watch_cb, s);
>>>
>>> In hw/candence_uart.c, it is cadence_uart_xmit, setting by the following code,
>>>
>>>          guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>>>
>>>                                          cadence_uart_xmit, s);
>>>
>>>
>>>
>>> I tried to call it with booting a Linux, but the interface will never be called.
>>>
>>> Can someone give a reasonable answer why needs this interface, or a way to call it.
>> This code is here to handle the case where the UART wants to pass
>> data to the chardev which is acting as the backend to the UART
>> (which might be host stdio, a TCP port, etc), but the backend
>> cannot accept data.
>>
>> Older UART code (eg hw/char/pl011.c) calls qemu_chr_fe_write_all()
>> to write data, but this is a blocking call and these calls are
>> usually marked with an XXX/TODO comment, because if the chardev
>> backend can't currently accept the data then execution of the
>> guest will be blocked until the backend does start to accept
>> data again.
>>
>> The solution to this bug was the introduction of the non-blocking
>> qemu_chr_fe_write() call. But to use the non-blocking call, the
>> UART emulation code now needs to handle the case where
>> qemu_chr_fe_write() says "I couldn't write all the data you asked
>> me to". In that case, it must use qemu_chr_fe_add_watch() to
>> request a callback when the chardev is able to accept new data,
>> so that it can try again. (It also needs to emulate telling the
>> guest that the transmit FIFO is not yet empty via whatever status
>> registers the UART has for that, because in the meantime guest
>> execution will continue with some of the data still not sent to
>> the chardev, but sitting in the emulated FIFO; and it needs to
>> correctly emulate "guest tried to write more data to a full FIFO".
>> Older UART emulations that use the blocking write_all function
>> don't need to bother with these details because there the tx
>> FIFO is always empty -- from the guest's perspective data written
>> to the tx FIFO drains instantaneously.)
>>
>> The common case execution path is "the chardev can accept the data
>> faster than the guest can feed it to the UART", in which case
>> qemu_chr_fe_write() will return 'wrote all the data' and the
>> UART never needs to call qemu_chr_fe_add_watch(). To exercise the
>> add-watch codepath you need to connect the UART to a chardev
>> that can be made to stop accepting data (for instance a pipe
>> or a unix domain socket where there's nothing on the other end
>> reading data.)
> Hi Peter,
>
> Thanks, it's really a reasonable answer. However I still have one 
> question.
>
> When I tried to verify the code-path, the callback is not triggered.
> The serial I used is hw/serial.c, back ended with a named pipe.
>
> The first step is make named pipe by
> mkfifo xpipe
> Then run a RISC-V Linux by the command
> gdb --args qemu-system-riscv64 -M virt -kernel fw_jump.elf -device loader,file=Image,addr=0x80200000 \
> -append "rootwait root=/dev/vda ro" -drive file=rootfs.ext2,format=raw,id=hd0 \
> -device virtio-blk-device,drive=hd0 -serial pipe:xpipe -smp 1
> Set a breakpoint on serial_watch_cb before run the Linux
> b serial_watch_cb
> Then run the Linux. The breakpoint will never matched.  I think "there 
> is nothing on the other end reading data".
>
> Then I tried another way to verify. Read the pipe a little later after 
> booting(There are some data in the FIFO already) by
> cat xpipe
> Now I can read some data out from the pipe. But it still can't match 
> the breakpoint. I think the reading  will set the G_IO_OUT condition,
> but it doesn't.
>
> Is there something wrong? Or could you show me a case./
> /
Hi folks,

I find it's the pipe buffer size is big enough to contain all the output 
of Linux booting.
So it will not call the qemu_chr_fe_add_watch.

If I output more characters more than 64KB,  it will call the 
qemu_chr_fe_add_watch and serial_watch_cb.

By this way, I verify the code-path.

Thanks Peter. It's really a right answer.

Zhiwei/
/
> /
> /Best Regards,
> Zhiwei/
> /
>> thanks
>> -- PMM
>


--------------B0241B05D7EA495B74B2B7F6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/5 10:19, LIU Zhiwei wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:7eb57b4e-8d74-38c2-b8fd-00b6e2e99975@c-sky.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2020/6/4 21:32, Peter Maydell
        wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Thu, 4 Jun 2020 at 13:15, LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com" moz-do-not-send="true">&lt;zhiwei_liu@c-sky.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback function.

In hw/serial.c, it is serial_watch_cb, setting by the following code,

  s-&gt;watch_tag = qemu_chr_fe_add_watch(&amp;s-&gt;chr, G_IO_OUT | G_IO_HUP,

                      serial_watch_cb, s);

In hw/candence_uart.c, it is cadence_uart_xmit, setting by the following code,

        guint r = qemu_chr_fe_add_watch(&amp;s-&gt;chr, G_IO_OUT | G_IO_HUP,

                                        cadence_uart_xmit, s);



I tried to call it with booting a Linux, but the interface will never be called.

Can someone give a reasonable answer why needs this interface, or a way to call it.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This code is here to handle the case where the UART wants to pass
data to the chardev which is acting as the backend to the UART
(which might be host stdio, a TCP port, etc), but the backend
cannot accept data.

Older UART code (eg hw/char/pl011.c) calls qemu_chr_fe_write_all()
to write data, but this is a blocking call and these calls are
usually marked with an XXX/TODO comment, because if the chardev
backend can't currently accept the data then execution of the
guest will be blocked until the backend does start to accept
data again.

The solution to this bug was the introduction of the non-blocking
qemu_chr_fe_write() call. But to use the non-blocking call, the
UART emulation code now needs to handle the case where
qemu_chr_fe_write() says "I couldn't write all the data you asked
me to". In that case, it must use qemu_chr_fe_add_watch() to
request a callback when the chardev is able to accept new data,
so that it can try again. (It also needs to emulate telling the
guest that the transmit FIFO is not yet empty via whatever status
registers the UART has for that, because in the meantime guest
execution will continue with some of the data still not sent to
the chardev, but sitting in the emulated FIFO; and it needs to
correctly emulate "guest tried to write more data to a full FIFO".
Older UART emulations that use the blocking write_all function
don't need to bother with these details because there the tx
FIFO is always empty -- from the guest's perspective data written
to the tx FIFO drains instantaneously.)

The common case execution path is "the chardev can accept the data
faster than the guest can feed it to the UART", in which case
qemu_chr_fe_write() will return 'wrote all the data' and the
UART never needs to call qemu_chr_fe_add_watch(). To exercise the
add-watch codepath you need to connect the UART to a chardev
that can be made to stop accepting data (for instance a pipe
or a unix domain socket where there's nothing on the other end
reading data.)</pre>
      </blockquote>
      Hi Peter,<br>
      <br>
      Thanks, it's really a reasonable answer. However I still have one
      question.<br>
      <br>
      When I tried to verify the code-path, the callback is not
      triggered.<br>
      The serial I used is hw/serial.c, back ended with a named pipe.<br>
      <br>
      The first step is make named pipe by<br>
      <pre>mkfifo xpipe</pre>
      Then run a RISC-V Linux by the command<br>
      <pre style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; overflow-wrap: break-word; white-space: pre-wrap;">gdb --args qemu-system-riscv64 -M virt -kernel fw_jump.elf -device loader,file=Image,addr=0x80200000 \
-append "rootwait root=/dev/vda ro" -drive file=rootfs.ext2,format=raw,id=hd0 \
-device virtio-blk-device,drive=hd0 -serial pipe:xpipe -smp 1
</pre>
      Set a breakpoint on serial_watch_cb before run the Linux<br>
      <pre>b serial_watch_cb
</pre>
      Then run the Linux. The breakpoint will never matched.  I think
      "there is nothing on the other end reading data".<br>
      <br>
      Then I tried another way to verify. Read the pipe a little later
      after booting(There are some data in the FIFO already) by<br>
      <pre>cat xpipe</pre>
      Now I can read some data out from the pipe. But it still can't
      match the breakpoint. I think the reading  will set the G_IO_OUT
      condition,<br>
      but it doesn't.<br>
      <br>
      Is there something wrong? Or could you show me a case.<i><br>
      </i></blockquote>
    Hi folks,<br>
    <br>
    I find it's the pipe buffer size is big enough to contain all the
    output of Linux booting. <br>
    So it will not call the qemu_chr_fe_add_watch.<br>
    <br>
    If I output more characters more than 64KB,  it will call the
    qemu_chr_fe_add_watch and serial_watch_cb.<br>
    <br>
    By this way, I verify the code-path.<br>
    <br>
    Thanks Peter. It's really a right answer.<br>
    <br>
    Zhiwei<i><br>
    </i>
    <blockquote type="cite"
      cite="mid:7eb57b4e-8d74-38c2-b8fd-00b6e2e99975@c-sky.com"><i> <br>
      </i>Best Regards,<br>
      Zhiwei<i><br>
      </i><br>
      <blockquote type="cite"
cite="mid:CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">thanks
-- PMM
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------B0241B05D7EA495B74B2B7F6--

