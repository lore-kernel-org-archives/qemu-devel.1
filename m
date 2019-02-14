Received: from eggs.gnu.org ([209.51.188.92]:49207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKE2-00042Z-MA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKE1-00077G-Ht
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guKE0-0006yf-B4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:51:01 -0500
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-38-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-F-4WQ4OrEYh_sjpgxGOoAY3ZLpwhro0GTw3Dva1o7xw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d79f968-4952-172c-65d6-8c03e1f028f9@redhat.com>
Date: Thu, 14 Feb 2019 17:50:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F-4WQ4OrEYh_sjpgxGOoAY3ZLpwhro0GTw3Dva1o7xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 37/76] i386: import & use bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefano Garzarella <sgarzare@redhat.com>

On 14/02/19 17:40, Peter Maydell wrote:
>> ---
>>  hw/i386/pc.c                                 |  8 +------
>>  include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++++++++++
>>  scripts/update-linux-headers.sh              |  6 +++++
>>  3 files changed, 41 insertions(+), 7 deletions(-)
>>  create mode 100644 include/standard-headers/asm-x86/bootparam.h
> Hi -- I just noticed this commit while I was looking through
> git logs for a different reason. For future changes to
> the standard-headers/, can we keep the "change the update
> script" patches separate from the "and now update the headers
> from upstream kernel commit X with the new script" parts,
> please? Otherwise it's very hard to be sure that the header
> changes are correct and that we still have an in-sync
> set of header files that aren't a patchwork of files from
> different versions. (For instance, this commit claims it is
> "from v4.20-rc5", but the rest of the header files are already
> at 4.21-rc1/5.0-rc1.)

Yes, will do.  (FWIW, the file hasn't changed between v4.20-rc5 and
v5.0-rc1).

Paolo
