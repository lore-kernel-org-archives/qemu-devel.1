Received: from eggs.gnu.org ([2001:4830:134:3::10]:34962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrRr-00005p-FY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csrRq-0000Jg-L1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:46:11 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csrRq-0000IU-Em
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:46:10 -0400
Received: by mail-wr0-x234.google.com with SMTP id w43so91569339wrb.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 06:46:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328134418.3426-1-stefanha@redhat.com>
References: <20170328134418.3426-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 14:45:48 +0100
Message-ID: <CAFEAcA9hpGG390Zd11eb2J__A+zDppHKbxcV7bRJeEHqww4_gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] configure: eliminate Python dependency
 for --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 14:44, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The ./configure script should produce --help output even if Python is
> not installed.
>
> Listing trace backends is simple: show the names of all Python modules
> in scripts/tracetool/backend/ whose source code contains 'PUBLIC =
> True'.
>
> Perform the backend enumeration in shell instead of Python so that we
> can move the Python check until after ./configure --help.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
