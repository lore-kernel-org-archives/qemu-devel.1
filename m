Received: from eggs.gnu.org ([2001:4830:134:3::10]:36710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <okaya@codeaurora.org>) id 1cgBhL-0004CB-3D
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <okaya@codeaurora.org>) id 1cgBhK-00015T-07
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:45:47 -0500
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
	<1487683100-16013-2-git-send-email-eric.auger@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <98d4d9e8-761c-76f9-ecb0-c5a4a658dfab@codeaurora.org>
Date: Tue, 21 Feb 2017 09:45:31 -0500
MIME-Version: 1.0
In-Reply-To: <1487683100-16013-2-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/platform: make the vfio-platform
 device non abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Hi Eric,
Thanks for the long anticipated patch.

On 2/21/2017 8:18 AM, Eric Auger wrote:
> +    DEFINE_PROP_STRING("manufacturer", VFIOPlatformDevice, manufacturer),
> +    DEFINE_PROP_STRING("model", VFIOPlatformDevice, model),

The OF string is not always of the format "manufacturer, model".

HIDMA for instance uses a syntax of "qcom, hidma-1.0" and "qcom, hidma-2.0".
This syntax is used for cases where an IP gets used in multiple SOCs. 

Maybe, we should call it just compatible-string and try not to make meaning
out of it.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
