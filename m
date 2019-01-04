Received: from eggs.gnu.org ([208.118.235.92]:56341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfPgD-000430-MC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfPg8-0005lD-Ce
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:38:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfPg8-0005kp-1r
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:38:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so36588108wrt.13
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:38:23 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-14-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <441bd501-6d1e-8b97-f275-75ad0ca66f25@redhat.com>
Date: Fri, 4 Jan 2019 14:38:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-14-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On 27/12/18 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> This lets you disable SCSI altogether with "CONFIG_SCSI=n".

USB_STORAGE_BOT and USB_STORAGE_UAS must also select SCSI.

Paolo
