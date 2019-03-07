Received: from eggs.gnu.org ([209.51.188.92]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h20IF-0006mF-0a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h20IC-0007Tk-Lm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:11:06 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h20I8-0007E4-7F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:11:02 -0500
Received: by mail-wm1-f50.google.com with SMTP id a188so10567220wmf.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 13:10:46 -0800 (PST)
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b15343fd-7a0f-4fae-01c3-24b558c349d7@redhat.com>
Date: Thu, 7 Mar 2019 22:10:41 +0100
MIME-Version: 1.0
In-Reply-To: <a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 04/03/19 12:08, Philippe Mathieu-Daudé wrote:
> +macos_task:
> +  osx_instance:
> +    image: high-sierra-base
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script:
> +    - brew install pkg-config glib pixman make sdl2

Could you also install Python 3 ("python" in Homebrew is 3.7) and avoid
Apple's obsolete /usr/bin/python (also needs something like
--python=/usr/local/bin/python3 in ./configure below).

Thanks,

Paolo

> +  script:
> +    - ./configure || { cat config.log; exit 1; }
> +    - gmake -j$(sysctl -n hw.ncpu)
> +    - gmake check -j$(sysctl -n hw.ncpu)
