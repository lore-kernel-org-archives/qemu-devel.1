Received: from eggs.gnu.org ([2001:4830:134:3::10]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnNJp-0005io-5t
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnNJl-000535-Vl
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:12:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnNJl-00052b-J2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:11:57 -0400
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-9-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6823c45-d95f-ba5d-2944-c8fabc2772ba@redhat.com>
Date: Wed, 8 Aug 2018 14:11:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-9-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/22] check: Only test tpm devices when
 they are compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index eae89b0fc0..47a5b66cde 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -299,10 +299,10 @@ check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>  gcov-files-i386-y += hw/pci-host/q35.c
>  check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
>  check-qtest-x86_64-$(call lor, $(CONFIG_VHOST_USER_NET_TEST_i386), $(CONFIG_VHOST_USER_NET_TEST_x86_64)) += tests/vhost-user-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-swtpm-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-swtpm-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
