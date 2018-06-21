Received: from eggs.gnu.org ([2001:4830:134:3::10]:44954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVuQD-0003vh-Sg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVuQD-0002Oj-6Z
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:54:25 -0400
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
	<1528790908-23441-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_rgm7KX+Tm+TkgoKEfAV0f-vAeoQ5dv_jBzfA47kAWNw@mail.gmail.com>
	<CAFEAcA84MpwJj8n0LvyE0BrfuJLCfB4rVWT=o0GcDn-6HpMThA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dfcf6ddb-5bde-ea8c-6b26-e44cc5e1632c@redhat.com>
Date: Thu, 21 Jun 2018 09:54:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84MpwJj8n0LvyE0BrfuJLCfB4rVWT=o0GcDn-6HpMThA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi Peter,

On 06/20/2018 06:10 PM, Peter Maydell wrote:
> On 20 June 2018 at 16:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 12 June 2018 at 09:08, Eric Auger <eric.auger@redhat.com> wrote:
>>> +smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
>>> +smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
>>
>> Does our tracing infrastructure really support floats? There
>> is no other use of it in the tree. There is one instance of
>> 'double', though, so maybe we do.
>>
>> In general I think we should prefer 'double' over 'float' anyway,
>> though.
> 
> I asked Stefan on IRC and the systemtap backend doesn't support
> float or double, so we need to use an integer type here.
> Lazy approach is to just round the % to an integer; if you think
> the extra precision is useful then you can have %d.%d and
> calculate the 10th-of-a-percent digit or something.
Oh OK thanks.

I will adopt the lazy approach then ;-)

Thanks

Eric
> 
> thanks
> -- PMM
> 
