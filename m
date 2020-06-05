Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447E92074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 02:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447E92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1y5-0002UJ-Is
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 22:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jh1xX-0001yS-4Z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 22:19:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jh1xU-0001EN-Il
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 22:19:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0443779|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00255807-7.71053e-05-0.997365;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HiLAaKj_1591323578; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HiLAaKj_1591323578)
 by smtp.aliyun-inc.com(10.147.42.198);
 Fri, 05 Jun 2020 10:19:38 +0800
Subject: Re: hw/char: a question about watch callback function in serial
To: Peter Maydell <peter.maydell@linaro.org>
References: <81607772-7cbc-1d61-2687-313f6389e1eb@c-sky.com>
 <CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <7eb57b4e-8d74-38c2-b8fd-00b6e2e99975@c-sky.com>
Date: Fri, 5 Jun 2020 10:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------861BB7524518A6AA11F059D2"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 22:19:39
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
--------------861BB7524518A6AA11F059D2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/4 21:32, Peter Maydell wrote:
> On Thu, 4 Jun 2020 at 13:15, LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback function.
>>
>> In hw/serial.c, it is serial_watch_cb, setting by the following code,
>>
>>    s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>>
>>                        serial_watch_cb, s);
>>
>> In hw/candence_uart.c, it is cadence_uart_xmit, setting by the following code,
>>
>>          guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
>>
>>                                          cadence_uart_xmit, s);
>>
>>
>>
>> I tried to call it with booting a Linux, but the interface will never be called.
>>
>> Can someone give a reasonable answer why needs this interface, or a way to call it.
> This code is here to handle the case where the UART wants to pass
> data to the chardev which is acting as the backend to the UART
> (which might be host stdio, a TCP port, etc), but the backend
> cannot accept data.
>
> Older UART code (eg hw/char/pl011.c) calls qemu_chr_fe_write_all()
> to write data, but this is a blocking call and these calls are
> usually marked with an XXX/TODO comment, because if the chardev
> backend can't currently accept the data then execution of the
> guest will be blocked until the backend does start to accept
> data again.
>
> The solution to this bug was the introduction of the non-blocking
> qemu_chr_fe_write() call. But to use the non-blocking call, the
> UART emulation code now needs to handle the case where
> qemu_chr_fe_write() says "I couldn't write all the data you asked
> me to". In that case, it must use qemu_chr_fe_add_watch() to
> request a callback when the chardev is able to accept new data,
> so that it can try again. (It also needs to emulate telling the
> guest that the transmit FIFO is not yet empty via whatever status
> registers the UART has for that, because in the meantime guest
> execution will continue with some of the data still not sent to
> the chardev, but sitting in the emulated FIFO; and it needs to
> correctly emulate "guest tried to write more data to a full FIFO".
> Older UART emulations that use the blocking write_all function
> don't need to bother with these details because there the tx
> FIFO is always empty -- from the guest's perspective data written
> to the tx FIFO drains instantaneously.)
>
> The common case execution path is "the chardev can accept the data
> faster than the guest can feed it to the UART", in which case
> qemu_chr_fe_write() will return 'wrote all the data' and the
> UART never needs to call qemu_chr_fe_add_watch(). To exercise the
> add-watch codepath you need to connect the UART to a chardev
> that can be made to stop accepting data (for instance a pipe
> or a unix domain socket where there's nothing on the other end
> reading data.)
Hi Peter,

Thanks, it's really a reasonable answer. However I still have one question.

When I tried to verify the code-path, the callback is not triggered.
The serial I used is hw/serial.c, back ended with a named pipe.

The first step is make named pipe by

mkfifo xpipe

Then run a RISC-V Linux by the command

gdb --args qemu-system-riscv64 -M virt -kernel fw_jump.elf -device loader,file=Image,addr=0x80200000 \
-append "rootwait root=/dev/vda ro" -drive file=rootfs.ext2,format=raw,id=hd0 \
-device virtio-blk-device,drive=hd0 -serial pipe:xpipe -smp 1

Set a breakpoint on serial_watch_cb before run the Linux

b serial_watch_cb

Then run the Linux. The breakpoint will never matched.  I think "there 
is nothing on the other end reading data".

Then I tried another way to verify. Read the pipe a little later after 
booting(There are some data in the FIFO already) by

cat xpipe

Now I can read some data out from the pipe. But it still can't match the 
breakpoint. I think the reading  will set the G_IO_OUT condition,
but it doesn't.

Is there something wrong? Or could you show me a case./

/Best Regards,
Zhiwei/
/
>
> thanks
> -- PMM


--------------861BB7524518A6AA11F059D2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/4 21:32, Peter Maydell wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, 4 Jun 2020 at 13:15, LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a> wrote:
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
      <pre class="moz-quote-pre" wrap="">
This code is here to handle the case where the UART wants to pass
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
    When I tried to verify the code-path, the callback is not triggered.<br>
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
    Now I can read some data out from the pipe. But it still can't match
    the breakpoint. I think the reading  will set the G_IO_OUT
    condition,<br>
    but it doesn't.<br>
    <br>
    Is there something wrong? Or could you show me a case.<i><br>
      <br>
    </i>Best Regards,<br>
    Zhiwei<i><br>
    </i><br>
    <blockquote type="cite"
cite="mid:CAFEAcA84BwfhEEk6_mG9Fzp8HizRUEm5cRQo-QhOory0Gz7Duw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

thanks
-- PMM
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------861BB7524518A6AA11F059D2--

