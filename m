Received: from eggs.gnu.org ([2001:4830:134:3::10]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fbS86-0004Sm-53
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fbS82-00036p-Vj
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fbS82-000367-QB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:54:34 -0400
References: <20180706143105.93472-1-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <01b97f86-acd8-bf8f-217d-9629d6584607@redhat.com>
Date: Fri, 6 Jul 2018 16:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180706143105.93472-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, quintela@redhat.com

On 06/07/2018 16:31, Dr. David Alan Gilbert (git) wrote:
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

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
