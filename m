Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dc5Ds-0007IE-2V
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dc5Dr-0001xW-93
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:34:40 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38538
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dc5Dr-0001wj-1r
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:34:39 -0400
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
	<CAFEAcA_38JueOfxmgB_w=Pcy9suaX7y+bfunDTvdMwFpZy+jsg@mail.gmail.com>
	<CAFEAcA9CPyeExbotokLwbuJwZcYt5iUPdFw=cx4uTLkipf5-XA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <bd2e0ea4-97c8-4080-7e17-891d6674d25a@adacore.com>
Date: Mon, 31 Jul 2017 09:34:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CPyeExbotokLwbuJwZcYt5iUPdFw=cx4uTLkipf5-XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>



On 07/28/2017 12:13 PM, Peter Maydell wrote:
> On 28 July 2017 at 10:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Talking to David about this on IRC, even "don't allow
>> migration" is a bit tricky, because you can't register
>> a migration-blocker if a migration is already in progress.
>> Two further options:
>>   * disable this mmio-exec-in-place entirely for 2.10 as
>>     being not completely baked yet, and fix it properly
>>     in 2.11
>>   * ditto, but allow the device to have an x-enable-exec-in-place
>>     property which turned on the not-baked feature (the
>>     property would go away in 2.11, which is OK because
>>     of the x- experimental prefix)
>>
>> I'm leaning towards disable-entirely at the moment...
> 
> I've sent a for-2.10 patch which takes the simple "just
> disable it" approach. If anybody wants to propose taking
> a less blunt hammer to it, they're welcome to send a patch.
> 
> thanks
> -- PMM
> 

Hi Peter,

I'll send a patch for this today or tomorrow.

Thanks,
Fred
