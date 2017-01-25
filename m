Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKaL-0003U1-2V
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKaH-0001s4-Tw
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWKaH-0001rW-OA
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:13:45 -0500
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
	<1485254930.32716.23.camel@redhat.com>
	<b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
	<1485260998.32716.45.camel@redhat.com> <20170124153143.GA29823@olga.wb>
	<dba0324f-e6c1-04e0-da0f-0e06a87d0375@redhat.com>
	<1485328680.29826.12.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f9b89fee-baeb-f967-e14f-362e59b2209c@redhat.com>
Date: Wed, 25 Jan 2017 11:13:42 +0100
MIME-Version: 1.0
In-Reply-To: <1485328680.29826.12.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>, liqiang6-s@360.cn, ghoffman@redhat.com, Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org

On 01/25/17 08:18, Gerd Hoffmann wrote:
>   Hi,
> 
>>> The negative pitch means (I think) that "addr" points to the lower
>>> left corner of the rectangle.
>>>
>>> The second part guarantees that the last blitted byte fits (lower
>>> right corner).
>>
>> To which Gerd responded "upper left". In retrospect I don't understand
>> why we didn't discuss that question further, as it now seems that we
>> were both wrong -- "addr" stands for bottom right, in the negative pitch
>> case.
> 
> /me looks at d3532a0db02296e687711b8cdc7791924efccea0 and I can't
> remember I wrote that code :-o

Haha, happens to me too :)

> And I can't remember the discussion either.
> 
> The good thing is I probably looked more careful at the code because of
> that ...
> 
>> Unfortunately, the original patch was meant to address the
>> then-embargoed CVE-2014-8106. Since we have a bug in that code (= a
>> security fix), this issue should have been reported privately as well,
> 
> It has been reported privately first.  I've actually suggested to send
> it to the public list without embargo, given that we are moving away
> from cirrus so this is less critical than it used to be two years ago.
> Cirrus isn't the default display adapter any more in qemu, since years,
> and management apps (virt-manager, ovirt, ...) are following.

Ah, I see -- a CVE is justified, but an embargo: likely not. Makes sense.

Thanks!
Laszlo
