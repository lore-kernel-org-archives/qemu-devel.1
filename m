Received: from eggs.gnu.org ([2001:4830:134:3::10]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTRp-0005Il-LT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTRo-0004yh-QR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:19:05 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbTRo-0004yE-C7
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:19:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so24489722oie.5
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706143105.93472-1-dgilbert@redhat.com>
References: <20180706143105.93472-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 17:18:43 +0100
Message-ID: <CAFEAcA9JBpv+psc7PeENohPOcurzWHYPk4Pg09WCQM0S74XYbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] tests/migration: Skip tests for ppc
 tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 6 July 2018 at 15:31, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> PPC tcg seems to be failing migration tests quite regularly;
> we believe this is TCG bugs in dirty bit updating; it's
> not clear why PPC fails more but lets skip for the moment.
>
> $ ./tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: Skipping test: kvm_hv not available OK
> /ppc64/migration/postcopy/unix: Skipping test: kvm_hv not available OK
> /ppc64/migration/precopy/unix: Skipping test: kvm_hv not available OK
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/migration-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>

Applied to master, thanks -- hopefully this will reduce the
number of spurious test failures I encounter.

-- PMM
