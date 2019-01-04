Received: from eggs.gnu.org ([208.118.235.92]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfPeP-0002W5-Hv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfPeF-000880-DP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:36:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfPeD-0007ww-L6
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:36:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so1164729wmj.1
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:36:23 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-4-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7ccdbb0-0931-c7a6-e829-4d375ef528e4@redhat.com>
Date: Fri, 4 Jan 2019 14:36:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-4-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/25] minikconfig: add parser skeleton
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

On 27/12/18 07:33, Yang Zhong wrote:
> +
> +# -------------------------------------------
> +# KconfigParser implements a recursive descent parser for (simplified)
> +# Kconfig syntax.  The static parse() method returns a KconfigData
> +# object, from which it is possible to build a BDD and compute a

s/BDD/DAG/ (BDD-based configuration seemed nifty but didn't work).

Paolo

> +# configuration
> +# -------------------------------------------
