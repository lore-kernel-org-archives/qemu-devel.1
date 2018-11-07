Received: from eggs.gnu.org ([2001:4830:134:3::10]:57425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKId0-0004B1-CP
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKIcy-0001T3-SF
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:51:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41692)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKIcw-0001ER-Rp
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:51:51 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
	<f37c22d1-3530-ef0a-21a6-7e4637163438@linaro.org>
In-Reply-To: <f37c22d1-3530-ef0a-21a6-7e4637163438@linaro.org>
Date: Wed, 7 Nov 2018 10:51:38 +0300
Message-ID: <000d01d4766e$b6a9abc0$23fd0340$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Richard Henderson' <richard.henderson@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, agraf@suse.de, david@gibson.dropbear.id.au

> From: Richard Henderson [mailto:richard.henderson@linaro.org]
> On 10/30/18 9:30 AM, Pavel Dovgalyuk wrote:
> > This patch fixes processing of mtmsr instructions in icount mode.
> > In this mode writing to interrupt/peripheral state is controlled
> > by can_do_io flag. This flag must be set explicitly before helper
> > function invocation.
> >
> > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  target/ppc/translate.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Richard, can you check the another similar patch?

https://patchew.org/QEMU/20181030122134.11055.15711.stgit@pasha-VirtualBox/


Pavel Dovgalyuk
