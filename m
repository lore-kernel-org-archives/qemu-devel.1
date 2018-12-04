Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUC0H-000158-5C
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUC0C-0006xZ-3j
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:48:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUC0B-0006wx-Aj
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:48:43 -0500
References: <CAFEAcA8rx-ZzHfb5ABcGBHOWDcDwxOejxp_SW9LLuOf1-_cxdg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <321187aa-69e8-ed78-7402-89026e1e9558@redhat.com>
Date: Tue, 4 Dec 2018 15:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rx-ZzHfb5ABcGBHOWDcDwxOejxp_SW9LLuOf1-_cxdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] hax_enabled() cannot be called in vl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Vincent Palatin <vpalatin@chromium.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 04/12/18 15:45, Peter Maydell wrote:
> kvm_enabled() does a similar thing to what hax_enabled() does,
> but this works out OK because it takes care to avoid
> providing the #define-to-0 implementation except in the
> case where it is building a target-specific file for a
> target where KVM is not enabled; for common files it
> will provide the function prototype which will end up
> linking to a stub implementation. So we could handle hax
> like that too.

Yes, the KVM one is the correct way to do it.  The #define-to-0
implementation is used so that the compiler can optimize out more code,
the function acts as a fallback.

Paolo
