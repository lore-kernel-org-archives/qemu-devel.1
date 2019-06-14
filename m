Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD914C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D6A21537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D6A21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnb1-0004Oi-Jc
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbn1x-00005N-0I
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbn1v-0000Tm-Ss
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:18:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbn1v-0000Sp-Md
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:18:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so2557266wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wJ2DCYzegHPQ1aR/5tabPSHOjwR4NrVnmi5JtYGHVZI=;
 b=mcZm7JiaKIT5kuekDDSK3nZDNSYBqceYUd2puFx99vHWsM4nAvalXjsrMpjxo5qOtM
 zeG5HIooOxBn6oRnqT/Vwn4IQHpx1ytvQIpz2gaeJolMwfBlxzqzvmZoKbiIZ3Gcf7l9
 n0FXDmXT0kES2vCSo0SLU908UzAseUlosmoB/9wKlP657COO/BDEqDY299/TEzIo4zld
 Td0CxO/qlq7eqUdQ1nuBQisbq8a6b/630iEUkslc4eRGPhnZ8xfeZDlQz4h8ycQeWb6Z
 5SAQ18kU/1/iHxgH/irBEaWsCAG0U6EuaWp3S3rf8nIcaiItQ/5wdzDyF/qrfJKOuBql
 /i1Q==
X-Gm-Message-State: APjAAAUjSYlUWhsC3vYuHMT7cUexvX7Df+eqLpT42rqNAtkOQPthRx79
 bkKNtBCGZJREn4/PuQEfcB3ULw==
X-Google-Smtp-Source: APXvYqzZNaJZXuJJ4SXCkrZl5P0jVxa3trtf9v3AYw4aB3MpHjOaSgcU9WynzbS11UIzgM55iEwh2A==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr8639971wmi.0.1560521890830;
 Fri, 14 Jun 2019 07:18:10 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l19sm1956024wmj.33.2019.06.14.07.18.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 07:18:10 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <26041dfd-0270-d637-22a2-30ce13c82bd4@redhat.com>
Date: Fri, 14 Jun 2019 16:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-7-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 6/8] VNC Acceptance test: simplify test
 names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 5:22 PM, Cleber Rosa wrote:
> The test name is composed of the class name and method name, so it
> looks like there's some redundancy here that we can eliminate.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/vnc.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index 675fd507ed..d32ae46685 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -45,7 +45,7 @@ class VncUnixSocket(Test):
>          self.socket_dir = tempfile.mkdtemp()
>          self.socket_path = os.path.join(self.socket_dir, 'vnc-socket')
>  
> -    def test_vnc_change_password_requires_a_password(self):
> +    def test_change_password_requires_a_password(self):
>          self.vm.add_args('-nodefaults', '-S',
>                           '-vnc', 'unix:%s' % self.socket_path)
>          self.vm.launch()
> @@ -60,7 +60,7 @@ class VncUnixSocket(Test):
>          self.assertEqual(set_password_response['error']['desc'],
>                           'Could not set password')
>  
> -    def test_vnc_change_password(self):
> +    def test_change_password(self):
>          self.vm.add_args('-nodefaults', '-S',
>                           '-vnc', 'unix:%s,password' % self.socket_path)
>          self.vm.launch()
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

