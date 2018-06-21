Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVpTs-00067X-Ff
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 22:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVpTp-0007QK-DG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 22:37:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fVpTp-0007Py-7V
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 22:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 842934059FE1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 02:37:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
References: <1529547496-25013-1-git-send-email-thuth@redhat.com>
Message-ID: <4ee46531-4b3e-8f53-0f33-a686065624ea@redhat.com>
Date: Thu, 21 Jun 2018 04:37:45 +0200
MIME-Version: 1.0
In-Reply-To: <1529547496-25013-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 21.06.2018 04:18, Thomas Huth wrote:
> The oldest machine type which is still used in a still maintained distro
> is a pc-0.12 based machine type in RHEL6, so everything that is older
> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
> and pc-0.11 so that we can finally remove them in a future release.
[...]
> @@ -3953,6 +3954,10 @@ int main(int argc, char **argv, char **envp)
>      }
>  
>      machine_class = select_machine();
> +    if (machine_class->deprecation_reason) {
> +        error_report("Machine type '%s' is deprecated: %s",
> +                     machine_class->name, machine_class->deprecation_reason);
> +    }

I just noticed that I need to check for !qtest_enabled() here, too,
otherwise these messages show up during "make check". I'll send a v3...

 Thomas
