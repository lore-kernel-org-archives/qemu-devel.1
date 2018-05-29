Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNejg-0002Kw-Bl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNeje-0005qa-M2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:32:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNeje-0005pq-GR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:32:22 -0400
Received: by mail-oi0-x244.google.com with SMTP id a6-v6so13041865oia.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 06:32:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b3d15f99-2e67-c0d4-7741-3af67d566734@amsat.org>
References: <20180524213756.7528-1-pbonzini@redhat.com>
	<b3d15f99-2e67-c0d4-7741-3af67d566734@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 14:32:01 +0100
Message-ID: <CAFEAcA_WW7un-gMHDv9YzTLkb5G7LBj0fUN+KFd-Ba-3MiC9mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm: fix malloc type mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 24 May 2018 at 22:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Cc'ing qemu-devel for patchew and co
>
> On 05/24/2018 06:37 PM, Paolo Bonzini wrote:
>> cpregs_keys is an uint32_t* so the allocation should use uint32_t.
>> g_new is even better because it is type-safe.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Applied to target-arm.next, thanks.

-- PMM
