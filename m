Received: from eggs.gnu.org ([2001:4830:134:3::10]:35447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJdZI-0000AN-Jq
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJdZE-0007lz-JV
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:29:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJdZE-0007lp-EJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:29:00 -0400
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-19-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9522df39-f4c5-4fba-10f3-33f9c4a1ff11@redhat.com>
Date: Fri, 18 May 2018 13:28:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 18/49] tests/tcg: enable building for
 i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 17/05/2018 19:46, Alex Benn=C3=A9e wrote:
> +
> +# Specialist test runners
> +.PHONY: pi_10.com
> +pi_10.com:
> +	cp $(I386_SRC)/pi_10.com .
> +
> +run-runcom: runcom pi_10.com
> +	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TES=
T", "$< on $(TARGET_NAME)")
> +

Why not just "$(QEMU) ./runcom $(I386_SRC)/pi_10.com" without the copy ru=
le?

Paolo
