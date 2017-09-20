Received: from eggs.gnu.org ([2001:4830:134:3::10]:38805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duf5a-0006Fm-N1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duf5V-0006ks-0a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:54 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:46957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1duf5U-0006k8-QH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:48 -0400
Received: by mail-wm0-x231.google.com with SMTP id i189so7263321wmf.1
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:30:48 -0700 (PDT)
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-7-famz@redhat.com>
	<874lryen8n.fsf@linaro.org> <20170920025317.GC18491@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170920025317.GC18491@lemon>
Date: Wed, 20 Sep 2017 10:35:54 +0100
Message-ID: <871sn1empx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 06/13] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com


Fam Zheng <famz@redhat.com> writes:

> On Tue, 09/19 16:12, Alex Bennée wrote:
>> Could we also do something about locales in this setup. The build gives
>> a lot of noise like:
>>
>>     perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
>>     perl: warning: Setting locale failed.
>>     perl: warning: Please check that your locale settings:
>>             LANGUAGE = (unset),
>>             LC_ALL = "en_GB.UTF-8",
>>             LC_TIME = "en_US.UTF-8",
>>             LC_CTYPE = "en_GB.UTF-8",
>>             LC_MONETARY = "en_US.UTF-8",
>>             LC_COLLATE = "C",
>>             LC_ADDRESS = "en_US.UTF-8",
>>             LC_TELEPHONE = "en_US.UTF-8",
>>             LC_NAME = "en_US.UTF-8",
>>             LC_MEASUREMENT = "en_US.UTF-8",
>>             LC_IDENTIFICATION = "en_US.UTF-8",
>>             LC_NUMERIC = "en_US.UTF-8",
>>             LC_PAPER = "en_US.UTF-8",
>>             LANG = "en_US.UTF-8"
>>         are supported and installed on your system.
>
> Not sure how en_GB gets into the guest (I assume it is from your host env, so
> it's SSH?). I'll add a locale directive in the cloud-init file anyway.

en_GB.UTF-8 is mine, not sure how the en_US stuff gets in there. My
general experience is most minimal installs seem to have broken locales
settings.

>
> Fam


--
Alex Bennée
