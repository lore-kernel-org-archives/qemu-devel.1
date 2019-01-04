Received: from eggs.gnu.org ([208.118.235.92]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQDk-0002tH-3F
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQDg-0008Ha-Tu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:13:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfQDg-0008Gy-8f
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:13:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so1252630wmd.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:13:03 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-5-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6341e9e-0166-53f2-690d-aa7e01a7e4ca@redhat.com>
Date: Fri, 4 Jan 2019 15:13:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-5-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/25] minikconfig: add AST
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
> +        self.clauses.append(KconfigData.DependsOnClause(var, expr))
>  
>      def do_select(self, var, symbol, cond=None):
> -        pass
> +        cond = (cond & var) if not (cond is None) else var

A better way to write this in Python is

    cond = (cond & var) if cond is not None else var

(My Python has improved since 2015 :)).

Paolo
