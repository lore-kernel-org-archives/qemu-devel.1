Received: from eggs.gnu.org ([2001:4830:134:3::10]:54573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebTZP-00052Q-IX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebTZL-0005qA-P0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:54:39 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebTZL-0005pb-J2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:54:35 -0500
Received: by mail-pg0-x243.google.com with SMTP id g16so3083702pgn.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:54:35 -0800 (PST)
References: <20180113144847.8403-1-laurent@vivier.eu>
	<20180113144847.8403-2-laurent@vivier.eu>
	<8106f80a-6bd2-8ba6-125a-6d5e58fcb035@linaro.org>
	<addf3223-da94-6573-5e87-408ec8367d4a@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6ba6a57-43fe-f4ee-4dac-0e5e7a3b49fd@linaro.org>
Date: Tue, 16 Jan 2018 07:54:31 -0800
MIME-Version: 1.0
In-Reply-To: <addf3223-da94-6573-5e87-408ec8367d4a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] linux-user: introduce functions to
 detect CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 01/16/2018 06:13 AM, Laurent Vivier wrote:
>> There is no reason to read the elf header twice -- e_flags has already been
>> stored in the struct image_info.
> 
> When we set cpu_model, image_info is not initialized.
> Do you propose to move cpu_init() after loader_exec()?

Sure.


r~
