Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfhF-0006d2-Fd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfhE-0002Eh-G3
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:11:01 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfhE-0002EQ-AV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:11:00 -0400
Received: by mail-ot0-x242.google.com with SMTP id 92-v6so107595otw.9
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:11:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rgm7KX+Tm+TkgoKEfAV0f-vAeoQ5dv_jBzfA47kAWNw@mail.gmail.com>
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
	<1528790908-23441-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_rgm7KX+Tm+TkgoKEfAV0f-vAeoQ5dv_jBzfA47kAWNw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:10:39 +0100
Message-ID: <CAFEAcA84MpwJj8n0LvyE0BrfuJLCfB4rVWT=o0GcDn-6HpMThA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/arm/smmuv3: Cache/invalidate
 config data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20 June 2018 at 16:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 June 2018 at 09:08, Eric Auger <eric.auger@redhat.com> wrote:
>> +smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
>> +smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
>
> Does our tracing infrastructure really support floats? There
> is no other use of it in the tree. There is one instance of
> 'double', though, so maybe we do.
>
> In general I think we should prefer 'double' over 'float' anyway,
> though.

I asked Stefan on IRC and the systemtap backend doesn't support
float or double, so we need to use an integer type here.
Lazy approach is to just round the % to an integer; if you think
the extra precision is useful then you can have %d.%d and
calculate the 10th-of-a-percent digit or something.

thanks
-- PMM
