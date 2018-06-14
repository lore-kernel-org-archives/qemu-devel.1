Received: from eggs.gnu.org ([208.118.235.92]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYIr-00076e-9g
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYIo-0006ay-E5
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:53:05 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYIo-0006af-8Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:53:02 -0400
Received: by mail-pg0-x243.google.com with SMTP id l65-v6so3380491pgl.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:53:02 -0700 (PDT)
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
Date: Thu, 14 Jun 2018 09:52:55 -1000
MIME-Version: 1.0
In-Reply-To: <20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/12/2018 10:19 PM, Greg Kurz wrote:
> I'm confused... I don't see anything related to HTM in TCG. Also we have
> the following in cap_htm_apply():
> 
>     if (tcg_enabled()) {
>         error_setg(errp,
>                    "No Transactional Memory support in TCG, try cap-htm=off");
> 
> I'm probably missing something... can you enlighten me ?

One of the two IBM machines -- and I thought it was ppc not s390x, but the code
you quote seems to deny that memory -- has stub support for TM within TCG.

To wit, the instructions are recognized and transactions always fail.  Which is
not a bad way to test the required fallback paths that rarely fail on hardware.
 ;-)


r~
