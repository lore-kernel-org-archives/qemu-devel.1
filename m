Received: from eggs.gnu.org ([2001:4830:134:3::10]:35448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNyp1-0004ro-Q1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNyox-0000qS-4s
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:54:43 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNyow-0000ox-U1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:54:39 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 77so16020605wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 02:54:38 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-2-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 10:55:21 +0100
Message-ID: <87h8z8tkhi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/21] tests: add missing dependency to
 build QTEST_QEMU_BINARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> This allow a one liner from fresh repository clone, i.e.:
>
>   ./configure && make -j check-qtest-aarch64

TIL -j doesn't need a number and GNU Make has a -l option ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 77da9b7f4b..f7c8f3eddb 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -823,7 +823,7 @@ GCOV_OPTIONS = -n $(if $(V),-f,)
>  # gtester tests, possibly with verbose output
>
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
> -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
> +$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  		QTEST_QEMU_IMG=qemu-img$(EXESUF) \


--
Alex Bennée
