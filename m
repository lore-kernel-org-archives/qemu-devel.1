Received: from eggs.gnu.org ([209.51.188.92]:49983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2G80-0000uU-N3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2G7y-0001nG-KF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2G7y-0001ex-EG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id o7so1393468wrp.12
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:05:34 -0800 (PST)
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e657733-2714-e9c9-1888-66d269e88b23@redhat.com>
Date: Fri, 8 Mar 2019 15:05:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190307130323.9353-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/14] pflash: Clean up after commit
 368a354f02b, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu

On 3/7/19 2:03 PM, Markus Armbruster wrote:
> Our pflash devices are simplistically modelled has having
> "num-blocks" sectors of equal size "sector-length".  Real hardware
> commonly has sectors of different sizes.  How our "sector-length"
> property is related to the physical device's multiple sector sizes
> is unclear.
> 
> Helper functions pflash_cfi01_register() and pflash_cfi02_register()
> create a pflash device, set properties including "sector-length" and
> "num-blocks", and realize.  They take parameters @size, @sector_len
> and @nb_blocs.
> 
> QOMification left parameter @size unused.  Obviously, @size should
> match @sector_len and @nb_blocs, i.e. size == sector_len * nb_blocs.
> All callers satisfy this.
> 
> Remove @nb_blocs and compute it from @size and @sector_len.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
