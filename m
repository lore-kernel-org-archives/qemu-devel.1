Received: from eggs.gnu.org ([2001:4830:134:3::10]:54165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFmSM-0001e9-7J
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFmSI-00007C-4K
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:58 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:37767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFmSH-00006v-WF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:09:54 -0400
Received: by mail-qt0-x234.google.com with SMTP id q13-v6so37275531qtp.4
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 13:09:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180504155918.21287-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e4f602a-9a5a-dd0a-06eb-d37b7a796c62@amsat.org>
Date: Mon, 7 May 2018 17:09:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/20] sdcard: proper implementation of CRC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

On 05/04/2018 12:58 PM, Philippe Mathieu-Daudé wrote:
> This series emerged after last Coverity scan and Peter suggestion in:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05046.html
> 
>     (3) "proper" implementation of CRC, so that an sd controller
>     can either (a) mark the SDRequest as "no CRC" and have
>     sd_req_crc_validate() always pass, or (b) mark the SDRequest
>     as having a CRC and have sd_req_crc_validate() actually
>     do the check which it currently stubs out with "return 0"
> 
> - Coverity issues fixed (up to patch 6)
> - crc16 now works
> - new functions documented
> - qtests added
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (20):
>   sdcard: Use the ldst API
>   sdcard: Extract sd_calc_frame48_crc7() from sd_req_crc_validate()
>   sdcard: Rename the SDRequest as SDFrame48
>   sdcard: Add sd_prepare_request[_with_crc]()
>   sdcard: Use the sd_prepare_request*() functions
>   sdcard: Add a "validate-crc" property
>   sdcard: Constify sd_crc*()'s message argument
>   sdcard: Fix sd_crc*() style
>   sdcard: Expose sd_crc*() functions for QTest use
>   sdcard: Expose sd_prepare_request*() functions for QTest use
>   sdcard: Add test_sd_request_frame_crc7() qtest (request command CRC7)
>   sdcard: Let sd_frame48_crc7_calc() work on response frames
>   sdcard: Expose sd_prepare_frame48() for QTest use
>   sdcard: Add test_sd_response_frame48_crc7 qtest (command response CRC7)
>   sdcard: Add SDFrame136 struct and 136-bit SD response frames functions
>   sdcard: Add test_sd_response_frame136_crc7() qtest
>   sdcard: Add SDFrameData struct and data frame checksum functions
>   sdcard: Fix sd_crc16()
>   sdcard: Add test_sd_data_frame_crc16() qtest
>   sdcard: Add test_sd_verify_cksum_frame48() qtest

Please disregard this series, I'll respin a simpler approach.
