Received: from eggs.gnu.org ([209.51.188.92]:56307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go4lP-0004CU-7S
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1go4lO-0004My-3x
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1go4lM-0004K7-Sl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id t200so13511443wmt.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:07:36 -0800 (PST)
References: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
	<8736pdnk7a.fsf@linaro.org>
	<20190128103900.ea6nxhm45u4p5mpd@function>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190128103900.ea6nxhm45u4p5mpd@function>
Date: Mon, 28 Jan 2019 11:07:32 +0000
Message-ID: <87zhrlm45n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: replace QEMU_BUILD_BUG_ON with
 G_STATIC_ASSERT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, jan.kiszka@siemens.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, zhangckid@gmail.com


Samuel Thibault <samuel.thibault@gnu.org> writes:

> Alex Benn=C3=A9e, le lun. 28 janv. 2019 10:35:37 +0000, a ecrit:
>> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
>>
>> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>
>> Is there a rationale as to why we should replace QEMU_BUILD_BUG_ON with
>> G_STATIC_ASSERT or is it particular to these QEMU_BUILD_BUG_ON
>> instances? It would be nice to have a little more context in the commit
>> message.
>
> It is yet more work towards moving slirp/ to a separately-maintained
> libslirp.

thanks, that makes more sense. If you could just mention that in the
commit it would save confusion about QEMU_BUILD_BUG_ON being deprecated
;-)

With that:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
