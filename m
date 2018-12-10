Received: from eggs.gnu.org ([2001:4830:134:3::10]:48073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHlb-0003L0-4t
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHlT-0005H1-5d
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:22:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWHlO-0005E2-VC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:22:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so10050315wmi.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 01:22:05 -0800 (PST)
References: <154422288914.14995.435815784241619944@bb8f5089e434>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db13f89b-be16-e80d-bf29-6153922ce63b@redhat.com>
Date: Mon, 10 Dec 2018 10:22:01 +0100
MIME-Version: 1.0
In-Reply-To: <154422288914.14995.435815784241619944@bb8f5089e434>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] fw_cfg: add HMP 'info fw_cfg' and
 add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, mst@redhat.com, lersek@redhat.com, dgilbert@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com, qemu-arm@nongnu.org, ehabkost@redhat.com

On 12/7/18 11:48 PM, no-reply@patchew.org wrote:
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
...
> The full log is available at
> http://patchew.org/logs/20181207170400.5129-1-philmd@redhat.com/testing.docker-quick@centos7/?type=message.

  qemu-system-x86_64: Back to tcg accelerator
  Broken pipe
  /tmp/qemu-test/src/tests/libqtest.c:125: kill_qemu() detected QEMU
death from signal 11 (Segmentation fault) (core dumped)
  GTester: last random seed: R02Sb6a4400485731f23217a8855e030b450
  Broken pipe

Probably the error Michael noticed:

>> +void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict)
>> +{
>> +    FWCfgState *s = fw_cfg_find();
>> +    int arch, key;
>
>  Looks like this will crash on a machine without fw cfg.
