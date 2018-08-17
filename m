Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqh12-0004Ub-OU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqh12-0008RI-5N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:50:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqh11-0008R4-WA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:50:20 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f859ae02-015a-5ef8-66b4-f54a630d1f5f@redhat.com>
Date: Fri, 17 Aug 2018 17:50:15 +0200
MIME-Version: 1.0
In-Reply-To: <1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com

On 10/08/2018 16:06, Robert Hoo wrote:
> +typedef enum FeatureWordType {
> +   CPUID_FEATURE_WORD,
> +   MSR_FEATURE_WORD,
> +} FeatureWordType;

This enum probably should be defined with QAPI, so that it can be reused
in the feature-words property:

# @X86CPUFeatureWordType:
#
# Kinds of X86 CPU feature words
#
# @cpuid: A CPUID leaf
#
# @msr: An MSR
##
{ 'enum': 'X86CPUFeatureWordType',
  'data': 'cpuid', 'msr' }

The names will be X86_CPU_FEATURE_WORD_TYPE_CPUID and
X86_CPU_FEATURE_WORD_TYPE_MSR.

Thanks,

Paolo
