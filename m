Received: from eggs.gnu.org ([2001:4830:134:3::10]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYea2-0004ek-Tx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYeZy-0005Z2-Vc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:35:54 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:33217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYeZy-0005YI-QU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:35:50 -0400
Received: by mail-qt0-x236.google.com with SMTP id l10-v6so6160949qtj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:35:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627174435.31800-1-alistair.francis@wdc.com>
	<CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23cb43c1-15aa-187b-3711-da7847396a01@amsat.org>
Date: Thu, 28 Jun 2018 18:35:40 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rRRTYhS-JNBTeJfZDydYEdNpab_TPieyrKcV5cad0SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair23@gmail.com>

On 06/28/2018 01:52 PM, Peter Maydell wrote:
> On 27 June 2018 at 18:44, Alistair Francis <alistair.francis@wdc.com> wrote:
>> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>>
>> are available in the Git repository at:
>>
>>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180627
>>
>> for you to fetch changes up to e5f5e16b67dc8a342f937bc00ebb2a6475e35050:
>>
>>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-27 10:35:19 -0700)
>>
> 
> Something strange is up with the key used to sign this:
> 
> $ gpg --recv-keys 7048B74B4C1B39E4
> gpg: requesting key 0x7048B74B4C1B39E4 from hkp server keys.gnupg.net
> gpg: key 0xE48E3BC2C123ED93: no valid user IDs
> gpg: this may be caused by a missing self-signature
> gpg: Total number processed: 1
> gpg:           w/o user IDs: 1

It seems the SKS keyserver pool is having some problem:
https://sks-keyservers.net/status/

$ host keys.gnupg.net
keys.gnupg.net is an alias for hkps.pool.sks-keyservers.net.
...
hkps.pool.sks-keyservers.net has address 18.191.65.131
hkps.pool.sks-keyservers.net has address 37.191.226.104
...

Except these 2 IP, all other failed via hkp or http (as of tod:

The server is temporarily unable to service your request due to
maintenance downtime or capacity problems. Please try again later.

Also:

Proxy Error
The proxy server received an invalid response from an upstream server.
The proxy server could not handle the request GET /pks/lookup.
Reason: Error reading from remote server

$ gpg --keyserver hkp://18.191.65.131 --recv-keys 7048B74B4C1B39E4
gpg: key E48E3BC2C123ED93: public key "Alistair Francis
<alistair@alistair23.me>" imported
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   4  signed:   3  trust: 0-, 0q, 0n, 0m, 0f, 4u
gpg: depth: 1  valid:   3  signed:  18  trust: 0-, 0q, 0n, 0m, 3f, 0u
gpg: depth: 2  valid:  16  signed:   6  trust: 10-, 6q, 0n, 0m, 0f, 0u
gpg: next trustdb check due at 2018-09-03
gpg: Total number processed: 1

$ git tag -v pull-riscv-pull-20180627
object e5f5e16b67dc8a342f937bc00ebb2a6475e35050
type commit
tag pull-riscv-pull-20180627
tagger Alistair Francis <alistair.francis@wdc.com> 1530121274 -0700
gpg: Signature made Wed 27 Jun 2018 02:41:26 PM -03
gpg:                using RSA key 100E2F7FE47ABA5024FF1B5B7048B74B4C1B39E4
gpg: Good signature from "Alistair Francis <alistair@alistair23.me>"
gpg:                 aka "Alistair Francis <alistair23@gmail.com>"
Primary key fingerprint: 29E0 5927 63B1 DA8C 8399  75FE E48E 3BC2 C123 ED93
     Subkey fingerprint: 100E 2F7F E47A BA50 24FF  1B5B 7048 B74B 4C1B 39E4
