Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6bnq-0007QR-8E
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6bnn-0002SG-1i
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:25:58 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6bnm-0002S6-Tv
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:25:54 -0400
Received: by mail-qt0-x243.google.com with SMTP id p1so25840217qtg.2
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 05:25:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171023102903.256AF7456A0@zero.eik.bme.hu>
	<894e2612-fe81-03bc-84d1-79dd9b6392f5@amsat.org>
Message-ID: <99e54ab2-c5b4-cd67-428d-f012e62f8062@amsat.org>
Date: Mon, 23 Oct 2017 09:25:51 -0300
MIME-Version: 1.0
In-Reply-To: <894e2612-fe81-03bc-84d1-79dd9b6392f5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 10/23/2017 08:09 AM, Philippe Mathieu-Daudé wrote:
> On 10/23/2017 07:24 AM, BALATON Zoltan wrote:
[...]
>>          info = g_new0(TPMInfoList, 1);
>> +#ifdef CONFIG_TPM
>>          info->value = tpm_backend_query_tpm(drv);
>> -
>> +#endif
>>          if (!cur_item) {
>>              head = cur_item = info;
>>          } else {
>> diff --git a/vl.c b/vl.c
>> index 0723835..dbfd06d 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
>>      res_free();
>>  
>>      /* vhost-user must be cleaned up before chardevs.  */
>> +#ifdef CONFIG_TPM
>>      tpm_cleanup();
>> +#endif
>>      net_cleanup();
>>      audio_cleanup();
>>      monitor_cleanup();
> 
> Can you instead add tpm_cleanup() in stubs/tpm.c?

and tpm_backend_query_tpm() ;)
