Received: from eggs.gnu.org ([2001:4830:134:3::10]:44028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBRxs-0001Qu-HT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBRxp-00088o-E9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:28:36 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:41202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBRxp-00088S-8N
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:28:33 -0400
Received: by mail-pg0-x22d.google.com with SMTP id m21so11236754pgv.8
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 14:28:33 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3bcdb8d9-2d67-c928-07ee-78c2a2e7e781@linaro.org>
Date: Wed, 25 Apr 2018 11:28:27 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 22/46] tests/tcg/i386: disable i386
 version of test-i386-ssse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
>  # Update TESTS
> -TESTS+=$(I386_TESTS)
> +TESTS+=$(I386_ONLY_TESTS)

Doesn't this depend on a variable you introduce in the next patch?


r~
