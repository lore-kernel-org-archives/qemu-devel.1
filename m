Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D7C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D324220888
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OynkapN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D324220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLIqJ-0007rL-PT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 00:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLIpD-0007Ht-Dl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 00:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLIpB-0005Kw-79
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 00:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600921540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZl7WNBRcdD0N0+RSPPLjIPBbtX8D65bAr4I1fmeYu8=;
 b=OynkapN13BJ3Q7pmwkA85WEtULTgu13dPPau3GuPXkg9vPMrdGPvM658qT8ylcN5LoEsgR
 h9Ok6ItheqmBVUghKuuac+pUB6nSc7Nz4YbFlQAJKbhDPh0V9y0hGpx6kHMrsGXD0jzJfL
 tHeg/RuX5wuP3s2TSTSEnWnwC54IGeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-sxJQY55eOqed6T2tXHjX1A-1; Thu, 24 Sep 2020 00:25:37 -0400
X-MC-Unique: sxJQY55eOqed6T2tXHjX1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B0556B36;
 Thu, 24 Sep 2020 04:25:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-39.ams2.redhat.com
 [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCCD702E7;
 Thu, 24 Sep 2020 04:25:30 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] hw/smbios: support loading OEM strings values from
 a file
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923104102.2068416-1-berrange@redhat.com>
 <20200923104102.2068416-2-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <71057ff8-77b9-2385-afe3-63d17a7e7138@redhat.com>
Date: Thu, 24 Sep 2020 06:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200923104102.2068416-2-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

On 09/23/20 12:41, Daniel P. Berrangé wrote:
> Some applications want to pass quite large values for the OEM strings
> entries. Rather than having huge strings on the command line, it would
> be better to load them from a file, as supported with -fw_cfg.
> 
> This introduces the "path" parameter allowing for:
> 
>   $ echo -n "thisthing" > mydata.txt
>   $ qemu-system-x86_64 \
>     -smbios type=11,value=something \
>     -smbios type=11,path=mydata.txt \
>     -smbios type=11,value=somemore \
>     ...other args...
> 
> Now in the guest
> 
> $ dmidecode -t 11
> Getting SMBIOS data from sysfs.
> SMBIOS 2.8 present.
> 
> Handle 0x0E00, DMI type 11, 5 bytes
> OEM Strings
> 	String 1: something
> 	String 2: thisthing
> 	String 3: somemore
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 7cc950b41c..8450fad285 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -110,7 +110,7 @@ static struct {
>  
>  static struct {
>      size_t nvalues;
> -    const char **values;
> +    char **values;
>  } type11;
>  
>  static struct {
> @@ -314,6 +314,11 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
>          .type = QEMU_OPT_STRING,
>          .help = "OEM string data",
>      },
> +    {
> +        .name = "path",
> +        .type = QEMU_OPT_STRING,
> +        .help = "OEM string data from file",
> +    },
>  };
>  
>  static const QemuOptDesc qemu_smbios_type17_opts[] = {
> @@ -641,6 +646,8 @@ static void smbios_build_type_11_table(void)
>  
>      for (i = 0; i < type11.nvalues; i++) {
>          SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
> +        g_free(type11.values[i]);
> +        type11.values[i] = NULL;
>      }
>  
>      SMBIOS_BUILD_TABLE_POST;
> @@ -940,9 +947,8 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
>  
>  
>  struct opt_list {
> -    const char *name;
>      size_t *ndest;
> -    const char ***dest;
> +    char ***dest;
>  };
>  
>  static int save_opt_one(void *opaque,
> @@ -951,23 +957,61 @@ static int save_opt_one(void *opaque,
>  {
>      struct opt_list *opt = opaque;
>  
> -    if (!g_str_equal(name, opt->name)) {
> -        return 0;
> +    if (g_str_equal(name, "path")) {
> +        g_autoptr(GByteArray) data = g_byte_array_new();
> +        g_autofree char *buf = g_new(char, 4096);
> +        ssize_t ret;
> +        int fd = qemu_open(value, O_RDONLY);

This line now fails to compile, due to commit c490af57cb45 ("util:
introduce qemu_open and qemu_create with error reporting", 2020-09-16).

... I guess I could test the patch with qemu_open_old(), but that
wouldn't allow for a valid Tested-by.

Thanks,
Laszlo

> +        if (fd < 0) {
> +            error_setg(errp, "Unable to open %s: %s", value, strerror(errno));
> +            return -1;
> +        }
> +
> +        while (1) {
> +            ret = read(fd, buf, 4096);
> +            if (ret == 0) {
> +                break;
> +            }
> +            if (ret < 0) {
> +                error_setg(errp, "Unable to read from %s: %s",
> +                           value, strerror(errno));
> +                return -1;
> +            }
> +            if (memchr(buf, '\0', ret)) {
> +                error_setg(errp, "NUL in OEM strings value in %s", value);
> +                return -1;
> +            }
> +            g_byte_array_append(data, (guint8 *)buf, ret);
> +        }
> +
> +        close(fd);
> +
> +        *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
> +        (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
> +        (*opt->ndest)++;
> +        data = NULL;
> +   } else if (g_str_equal(name, "value")) {
> +        *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
> +        (*opt->dest)[*opt->ndest] = g_strdup(value);
> +        (*opt->ndest)++;
> +    } else if (!g_str_equal(name, "type")) {
> +        error_setg(errp, "Unexpected option %s", name);
> +        return -1;
>      }
>  
> -    *opt->dest = g_renew(const char *, *opt->dest, (*opt->ndest) + 1);
> -    (*opt->dest)[*opt->ndest] = value;
> -    (*opt->ndest)++;
>      return 0;
>  }
>  
> -static void save_opt_list(size_t *ndest, const char ***dest,
> -                          QemuOpts *opts, const char *name)
> +static bool save_opt_list(size_t *ndest, char ***dest, QemuOpts *opts,
> +                          Error **errp)
>  {
>      struct opt_list opt = {
> -        name, ndest, dest,
> +        ndest, dest,
>      };
> -    qemu_opt_foreach(opts, save_opt_one, &opt, NULL);
> +    if (!qemu_opt_foreach(opts, save_opt_one, &opt, errp)) {
> +        return false;
> +    }
> +    return true;
>  }
>  
>  void smbios_entry_add(QemuOpts *opts, Error **errp)
> @@ -1149,7 +1193,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
>                  return;
>              }
> -            save_opt_list(&type11.nvalues, &type11.values, opts, "value");
> +            if (!save_opt_list(&type11.nvalues, &type11.values, opts, errp)) {
> +                return;
> +            }
>              return;
>          case 17:
>              if (!qemu_opts_validate(opts, qemu_smbios_type17_opts, errp)) {
> 


