Received: from eggs.gnu.org ([209.51.188.92]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1h1IWo-0003zh-GC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1h1IWj-0002Hm-PC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:27:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1h1IWg-0002EN-Ff
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:27:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x25MO3ZJ056693
	for <qemu-devel@nongnu.org>; Tue, 5 Mar 2019 17:27:01 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r21u0874q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:27:01 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 5 Mar 2019 22:27:00 -0000
References: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
	<CAFEAcA98oP70F9xDKwr8_9w4ATOmZvzbDuYHZF8MLH0paRHPyg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 5 Mar 2019 17:26:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98oP70F9xDKwr8_9w4ATOmZvzbDuYHZF8MLH0paRHPyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <3a65675e-cdb0-8f08-b658-1374e8acdeea@linux.ibm.com>
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2019/02/25 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3/4/19 11:43 AM, Peter Maydell wrote:
> On Mon, 4 Mar 2019 at 15:47, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>> The 1st patch in this series fixes a bug in the TPM TIS emulator that
>> skipped a locality when resetting the seize flag when a higher locality
>> seized access from a lower locality. The 2nd patch converts debugging
>> code to tracing.
>>
>>     Stefan
>>
>>
>> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>>
>>    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2019-02-25-1
>>
>> for you to fetch changes up to cd38cc519b60bbe5dd8d85f6aaa72b2d7902930b:
>>
>>    tpm_tis: convert tpm_tis_show_buffer() to use trace event (2019-02-24 14:46:14 -0500)
>>
>> ----------------------------------------------------------------
>> Liam Merwick (2):
>>        tpm_tis: fix loop that cancels any seizure by a lower locality
>>        tpm_tis: convert tpm_tis_show_buffer() to use trace event
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.


Done.


>
> -- PMM
>
