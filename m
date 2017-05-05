Received: from eggs.gnu.org ([2001:4830:134:3::10]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6X3y-0005Xs-Te
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6X3v-0003cy-SW
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:50:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:30735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d6X3v-0003ck-K4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:49:59 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<05c17619-e5df-7615-73e9-64b4b57fd570@linux.vnet.ibm.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <d7de07f7-587b-d873-a537-5d4bf8559c3e@intel.com>
Date: Fri, 5 May 2017 09:52:05 +0300
MIME-Version: 1.0
In-Reply-To: <05c17619-e5df-7615-73e9-64b4b57fd570@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Provide support for the software
 TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com



On 05/04/2017 03:28 PM, Stefan Berger wrote:
> On 05/02/2017 07:52 AM, Amarnath Valluri wrote:
>> Briefly, Theses set of patches introduces:
>>    - new TPM backend driver to support software TPM emulators(swtpm(1)).
>>    - and few supported fixes/enhancements/cleanup to existing tpm 
>> backend code.
>>
>>    The similar idea was initiated earliar(2) by Stefan Berger(CCed) 
>> with slightly
>>    different approach, using CUSE. As swtpm has excellent support for 
>> unix domain
>>    sockets, hence this implementation uses unix domain sockets to 
>> communicate
>>    with
>>    swtpm.
>
> I think you would need something like this as well:
>
> https://github.com/stefanberger/qemu-tpm/commit/9d8c9c3f0df288242d03f78d3b103099c1910574 
>
> https://github.com/stefanberger/qemu-tpm/commit/b9ea09d2e26eac92b4a1604a7afa695c4fc2735e 
>
Thanks Stefan, Sure we can take them in once after this patch series get 
accepted.

- Amarnath
