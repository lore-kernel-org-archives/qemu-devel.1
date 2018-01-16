Received: from eggs.gnu.org ([2001:4830:134:3::10]:55072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUXw-0000hw-4f
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUXs-0007Jj-85
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:57:12 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebUXr-0007Iz-UX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:57:08 -0500
References: <20180113144847.8403-1-laurent@vivier.eu>
	<20180113144847.8403-2-laurent@vivier.eu>
	<8106f80a-6bd2-8ba6-125a-6d5e58fcb035@linaro.org>
	<addf3223-da94-6573-5e87-408ec8367d4a@vivier.eu>
	<f6ba6a57-43fe-f4ee-4dac-0e5e7a3b49fd@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9ec4c7b4-50fd-5f8d-d238-1c92f76357fa@vivier.eu>
Date: Tue, 16 Jan 2018 17:56:47 +0100
MIME-Version: 1.0
In-Reply-To: <f6ba6a57-43fe-f4ee-4dac-0e5e7a3b49fd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 16/01/2018 à 16:54, Richard Henderson a écrit :
> On 01/16/2018 06:13 AM, Laurent Vivier wrote:
>>> There is no reason to read the elf header twice -- e_flags has already been
>>> stored in the struct image_info.
>>
>> When we set cpu_model, image_info is not initialized.
>> Do you propose to move cpu_init() after loader_exec()?
> 
> Sure.

After checking, I think we can't move cpu_init() after loader_exec():

load_elf_binary() needs to fill AT_HWCAP and in the case of i386 it
depends on cpu->env.features[FEAT_1_EDX] that comes from the cpu model.

Thanks,
Laurent
