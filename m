Received: from eggs.gnu.org ([2001:4830:134:3::10]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZcO8-0000fL-IQ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZcO3-0008GH-4M
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:55:20 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:42831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZcO2-0008F0-TJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:55:15 -0500
Received: by mail-wm0-x22f.google.com with SMTP id b141so5387635wme.1
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 04:55:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082738.27295.80055.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e223aaa-c3c9-1cdf-5548-5a532d3a7361@redhat.com>
Date: Thu, 11 Jan 2018 13:55:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180111082738.27295.80055.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/30] replay: improve replay
 performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 11/01/2018 09:27, Pavel Dovgalyuk wrote:
> +        } else {
> +            qemu_notify_event();
> +        }

Before this patch, what would do the qemu_notify_event?

Thanks,

Paolo

>          /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
