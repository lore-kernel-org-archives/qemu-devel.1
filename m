Received: from eggs.gnu.org ([2001:4830:134:3::10]:55405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjec-0006ms-1M
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjeY-0008Pi-RS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnjeY-0008P7-IT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:26:06 -0400
References: <1489345956-29167-1-git-send-email-mst@redhat.com>
	<CAFEAcA-FFPK_hFEydB7JWj=Zmgp3hs2e=n0vzuun97xnzc9JRQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67a2f6d0-1226-3def-f410-533c7062c92c@redhat.com>
Date: Tue, 14 Mar 2017 11:26:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FFPK_hFEydB7JWj=Zmgp3hs2e=n0vzuun97xnzc9JRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>



On 12/03/2017 20:35, Peter Maydell wrote:
>> +
>> +static inline uint64_t int128_printf1(Int128 a)
>> +{
>> +    /* We assume 4 highest bits are clear and safe to ignore */
>> +    return (int128_gethi(a) << 4) | (int128_getlo(a) >> 60);
>> +}
>> +
>> +static inline uint64_t int128_printf2(Int128 a)
>> +{
>> +    return (int128_getlo(a) << 4) >> 4;
>> +}
> I'm confused -- I was expecting these to just
> be the two halves of the 128 bit integer to be
> printed, but they seem to be doing something
> more complicated...

Yeah, it tries to make a 16 hex-digit output unless the value doesn't
fit in 64 bits.  I'll merge peterx's patch instead.

Paolo
