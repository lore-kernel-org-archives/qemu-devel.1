Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbeP-0000zs-4o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbeK-0001ei-9d
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQbeK-0001eX-46
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:46:32 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
Date: Thu, 29 Jun 2017 17:46:26 +0200
MIME-Version: 1.0
In-Reply-To: <98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

On 29.06.2017 17:06, Paolo Bonzini wrote:
> 
> 
> On 29/06/2017 10:46, Thomas Huth wrote:
>>> Patches 7,8 are the removal, marked RFC... let's debate!
>> ... but NACK for a direct removal. Common sense is to make obsolete
>> features as deprecated first and then wait for 2 public releases before
>> the final removal, so that users still have a chance to speak up in case
>> they still need the feature and are willing to maintain it.
> 
> I think this is a slightly different case than what is in
> http://wiki.qemu.org/Features/LegacyRemoval.
> 
> TCI is enabled only with a specific configure argument if your machine
> is not supported by TCG.  This would break _build_ configurations, not
> user configurations.  It's a remote possibility that users are building
> their own QEMU, with TCI enabled, to work around a TCG bug.  So we can
> be more speedy in removing the code.

You never know ... it's unlikely, but there might be people around who
run configure with "--enable-tcg-interpreter" on purpose. And why the
hurry for removing this? It's been around in the current shape since
years, so waiting for two more releases does not hurt, does it?

 Thomas
