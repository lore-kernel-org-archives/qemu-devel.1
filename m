Received: from eggs.gnu.org ([2001:4830:134:3::10]:54826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH8ZN-0002n4-9Y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH8ZM-0006UB-Et
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:33 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH8ZM-0006Tx-AB
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:26:32 -0500
Received: by mail-ot0-x241.google.com with SMTP id b17so10499412oth.2
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 05:26:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151121523989.31225.8242493880994615406@sif>
References: <20171107205201.10207-1-mdroth@linux.vnet.ibm.com>
	<151121523989.31225.8242493880994615406@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 13:26:11 +0000
Message-ID: <CAFEAcA_BsMvt_TLnv25D3YbBBURqx=5FKyLwKwLgzZKXRQfdag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH for-2.11]
 scripts/make-release: ship u-boot source as a tarball
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-stable <qemu-stable@nongnu.org>, Alexander Graf <agraf@suse.de>

On 20 November 2017 at 22:00, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Michael Roth (2017-11-07 14:52:01)
>> The u-boot sources we ship currently cause problems with unpacking on
>> a case-insensitive filesystem due to path conflicts. This has been
>> fixed in upstream u-boot via commit 610eec7f, but since it is not
>> yet included in an official release we implement this approach as a
>> temporary workaround.
>>
>> Once we move to a u-boot containing commit 610eec7f we should revert
>> this patch.
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
> Ping.
>
> Peter, would you be able to apply this directly? Not sure who else this
> would go through.

Sure. Applied to master for rc2.

thanks
-- PMM
