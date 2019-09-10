Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C65C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491122082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491122082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jPI-00083T-Bp
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7jLB-0002tq-6O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7jLA-0000kj-2A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:05 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36263)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7jL9-0000k8-PT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:04 -0400
Received: from [192.168.100.43] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1MuUvS-1iOZlU2kba-00rWmQ; Tue, 10 Sep 2019 18:49:50 +0200
To: Shu-Chun Weng <scw@google.com>
References: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
 <20190819180947.180725-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e5523e4b-1cf3-7b96-c064-7872def37c4f@vivier.eu>
Date: Tue, 10 Sep 2019 18:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819180947.180725-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5zYmv0Msmq0dgWzER3ts7tVUz0/UuhA8fpGhr3csQ2ZCAEmzNyy
 TxsL47gHpaLhXUzxApscriDdrVOx1u64wO6EuWFjuIETq3/YVKuY/ISHIryebR51GVhTJ4W
 N+jKfsXR8E78FDk6yN9wPL0NZi8YShbcv/9C4HwcD1oGYcmTKapssui/m0IOJ7ZIj05ZFjw
 OrmHJ4EGarilKB4ymYBlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8xJpkKGAWfM=:MiuBape0COFJyXzROjrflL
 Sccvy8vGGVEw36qLReTka1SmUxJjywwv9fqxGTjN0lUJ4pXYbK/3rQy7LyqUXVS/OJ4mkJq6Y
 sanT5Iq2b6pAWRC0ZmmmVJV9qzDL0sCLdtAmcGMr7ny6ik51LySu4KJsCa2VoIm4OCC5UAUdJ
 WswOvFLoLGU9iKSS+rYVtnzIgcRLaMr3eNYFGeD8DuY+Q+vR14mOggIAyNTb8dqa34JsgkEXe
 zrGpeC3BMQ5At+mrk2syboP+W3FzFxcTvyoYDO/0FE3FSirLE31r2iCUtVhvx4ajjHNasVhJ9
 KUPkRN1KESim1JFo8vvzlHwxnpwdljxMFJpFMGynd4ocn9Pn+3vkpfJeThbPWOjgT29mgVjZf
 nBZW6tTlwF7Z+wltaEm2l5KTBvupB7MVz5fXrZb/iospqiuLWo54bRM2O+2VafMQwJEx7wmqM
 Jn4Ik2ke1MKRfD0Kz2vAQ0CgrUEM+QY1AwK551YKfAllBqbmjkILIHd8Ot+nREqQDDLKfSYeg
 kaDh29nHDeu3bh/GNgoiY/GALfhMgOAPQ2J8Rm4yGOpb0TPP02D1XGAYsbNldQIyHH0uK+yow
 ByMZaD50Nc28CgUJ66CMHhrhliYDPJVqQVmKmzdEeHX0hVoBygbE336fUt6Ww24SLw84Y6oUy
 7kWBBxAbjqiMg3HtYB9ZRY13H5PE9OdZ47XeUUL78K9a1/QWqVgg1zJPwIhTvcHo1hNJeluSA
 BRYe7PK+4M6tI6HjeZmrI6AcmLcwoAFulhMcyvTDSpyIjsX3JYA2OzSd88v/Ri7rXFr25s1Dr
 jTTyos0zYPdLV1CO+Q9pN0TESJ7x9HdejrjVHUTx3zT0Ig6pcuO9MOFlJW3hXJsWmUwsn1vx5
 5IlqocEOXC/hUVqrVQpl65Z5mnUvHnnaucdG0w3fk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: add memfd_create
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arunkaly@google.com, riku.voipio@iki.fi, marcandre.lureau@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/2019 20:09, Shu-Chun Weng wrote:
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 12 ++++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)

A nice follow up to this patch would be to implement the file-sealing
APIs provided by fnctl (see memfd_create(2) and fcntl(2), File sealing).

Thanks,
Laurent

